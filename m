Date: Wed, 9 Aug 2000 18:12:48 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: rtc again...
In-Reply-To: <20000809170435.11366@mailhost.mipsys.com>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000809180837.866H-100000@ofey.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 9 Aug 2000, Benjamin Herrenschmidt wrote:

> Saving the timezone value to xpram is another issue. It could be done
> from userland but we currently don't have userland tool that properly
> access the xpram portion of the nvram. I did plan to add some ioctls to /
> dev/nvram for it to return the location of the various nvram partitions,
> looks like it will be time to actually implement them... Also, the
> userland tool will have to be written...

I had a xpram manipulation tool, so I modified it a bit.  Also, I added an
ioctl to drivers/macintosh/nvram.c.

Please have a look at them.  Are these what you had in mind?


Takashi Oe

Kernel mods:
--- linux-2.4.0-test4/include/asm-ppc/nvram.h	Tue May  2 15:05:40 2000
+++ linux-nubus/include/asm-ppc/nvram.h	Wed Aug  9 17:44:23 2000
@@ -38,12 +38,14 @@
 	pmac_nvram_NR		/* MacOS Name Registry partition */
 };

+#ifdef __KERNEL__
 /* Return partition offset in nvram */
 extern int	pmac_get_partition(int partition);

 /* Direct access to XPRAM */
 extern u8	pmac_xpram_read(int xpaddr);
 extern void	pmac_xpram_write(int xpaddr, u8 data);
+#endif /* __KERNEL__ */

 /* Some offsets in XPRAM */
 #define PMAC_XPRAM_MACHINE_LOC	0xe4
@@ -51,9 +53,12 @@

 /* Machine location structure in XPRAM */
 struct pmac_machine_location {
-	u32	latitude;	/* 2+30 bit Fractional number */
-	u32	longitude;	/* 2+30 bit Fractional number */
-	u32	delta;		/* mix of GMT delta and DLS */
+	unsigned int	latitude;	/* 2+30 bit Fractional number */
+	unsigned int	longitude;	/* 2+30 bit Fractional number */
+	unsigned int	delta;		/* mix of GMT delta and DLS */
 };
+
+/* /dev/nvram ioctls */
+#define PMAC_NVRAM_GET_OFFSET	_IOWR('p', 0x40, int) /* Get NVRAM partition offset */

 #endif
--- linux-2.4.0-test4/drivers/macintosh/nvram.c	Tue Jun 20 15:58:42 2000
+++ linux-nubus/drivers/macintosh/nvram.c	Wed Aug  9 16:44:50 2000
@@ -14,6 +14,7 @@
 #include <linux/nvram.h>
 #include <linux/init.h>
 #include <asm/uaccess.h>
+#include <asm/nvram.h>

 #define NVRAM_SIZE	8192

@@ -70,11 +71,36 @@
 	return p - buf;
 }

+static int nvram_ioctl(struct inode *inode, struct file *file,
+	unsigned int cmd, unsigned long arg)
+{
+	switch(cmd) {
+		case PMAC_NVRAM_GET_OFFSET:
+		{
+			int part, offset;
+			if (copy_from_user(&part,(void*)arg,sizeof(part))!=0)
+				return -EFAULT;
+			if (part < pmac_nvram_OF || part > pmac_nvram_NR)
+				return -EINVAL;
+			offset = pmac_get_partition(part);
+			if (copy_to_user((void*)arg,&offset,sizeof(offset))!=0)
+				return -EFAULT;
+			break;
+		}
+
+		default:
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 struct file_operations nvram_fops = {
 	owner:		THIS_MODULE,
 	llseek:		nvram_llseek,
 	read:		read_nvram,
 	write:		write_nvram,
+	ioctl:		nvram_ioctl,
 };

 static struct miscdevice nvram_dev = {


Userland utilitity: xpram.c

#include <stdio.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>

#include <time.h>
#include <fcntl.h>
#include <getopt.h>
#include <sys/ioctl.h>

#include <asm/nvram.h>

/* Globals */
int set_timezone = 0;

void
usage (char *str)
{
	fprintf (stderr,
		"%s offset [val]\n"
		"%s -t\n"
		"  t: update XPRAM timezone info\n", str, str);
	exit(EXIT_FAILURE);
}

int nvram_fd;

static void
nvram_init ( int rw_flag )
{
	if (rw_flag && getuid () != 0) {
		fprintf (stderr, "Sorry, must be root to set XPRAM value\n");
		exit(EXIT_FAILURE);
	}

	nvram_fd = open ("/dev/nvram", rw_flag? O_RDWR: O_RDONLY);
	if (nvram_fd < 0) {
		fprintf (stderr, "unable to open /dev/nvram read/write : %s\n",
			rw_flag? "read/write": "read only", strerror(errno));
		exit(EXIT_FAILURE);
	}
}

int
main (int argc, char **argv )
{
	int i, arg, rw = 0;
	unsigned long address;
	unsigned char val;
	char *p;
	extern int optind;

	while ((arg = getopt (argc, argv, "t")) != -1) {
		switch (arg) {
	        case 't':
			set_timezone = 1;
			break;
		default:
			usage (argv[0]);
		}
	}

	if (set_timezone) {
		address = PMAC_XPRAM_MACHINE_LOC;
		rw = 1;
	} else {
		if (!argv[optind])
			usage(argv[0]);

		address = strtoul(argv[optind], &p, 0);
		if (p == argv[optind])
			usage(argv[0]);
		if (argv[++optind]) {
			val = (unsigned char)strtoul(argv[optind], &p, 0);
			if (p == argv[optind])
				usage(argv[0]);
			rw = 1;
		}
	}

	nvram_init (rw);

	i = pmac_nvram_XPRAM;
	if (ioctl(nvram_fd, PMAC_NVRAM_GET_OFFSET, &i) < 0) {
		fprintf(stderr, "ioctl PMAC_NVRAM_GET_OFFSET: %s\n",
			strerror(errno));
		exit(EXIT_FAILURE);
	}
	address += i;

	if (set_timezone) {
		unsigned char buf[4];
		time_t gmt;
		int utc_offset;

		gmt = time( NULL );
		(void )localtime( &gmt );
		utc_offset = -timezone + (daylight? 3600: 0);
		if (lseek(nvram_fd, address + 8, 0) < 0
		    || read(nvram_fd, buf, 1) != 1) {
			fprintf(stderr, "Error reading from /dev/nvram: %s",
				strerror(errno));
			exit(EXIT_FAILURE);
		}
		buf[0] = (buf[0] & 0x7f) | ((daylight)? 0x80: 0);
		buf[1] = ((unsigned)(utc_offset) >> 16) & 0xff;
		buf[2] = ((unsigned)(utc_offset) >> 8) & 0xff;
		buf[3] = (unsigned)(utc_offset) & 0xff;
		if (lseek(nvram_fd, address + 8, 0) < 0
		    || write(nvram_fd, buf, 4) != 4) {
			fprintf(stderr, "Error writing to /dev/nvram: %s",
				strerror(errno));
			exit(EXIT_FAILURE);
		}
		exit(EXIT_SUCCESS);
	}

	if (!rw) {
		if (lseek(nvram_fd, address, 0) < 0
		    || read(nvram_fd, &val, 1) != 1) {
			fprintf(stderr, "Error reading from /dev/nvram: %s",
				strerror(errno));
			exit(EXIT_FAILURE);
		}
		printf("0x%02X\n", val);
	} else {
		if (lseek(nvram_fd, address, 0) < 0
		    || write(nvram_fd, &val, 1) != 1) {
			fprintf(stderr, "Error writing to /dev/nvram: %s",
				strerror(errno));
			exit(EXIT_FAILURE);
		}
	}

	exit(EXIT_SUCCESS);
}


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
