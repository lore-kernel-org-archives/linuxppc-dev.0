Return-Path: <mike.koss@ngc.com>
Received: from xmrm0101.northgrum.com (xmrm0101.northgrum.com
	[155.104.240.104]) by ozlabs.org (Postfix) with ESMTP id 05BCBDDF5C
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  8 Mar 2008 02:00:00 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Xilinx Temac link detect
Date: Fri, 7 Mar 2008 08:29:35 -0600
Message-ID: <EDAE140DF1B2FC42B5867C22CA0B333FA3CF03@XMBIL132.northgrum.com>
In-Reply-To: <20080306221446.4509A1118051@mail123-sin.bigfish.com>
References: <15616042.post@talk.nabble.com> <15883376.post@talk.nabble.com>
	<20080306221446.4509A1118051@mail123-sin.bigfish.com>
From: "Koss, Mike (Mission Systems)" <mike.koss@ngc.com>
To: "John Linn" <John.Linn@xilinx.com>, "khollan" <khollan@daktronics.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Here's a snippet from a program I use to debug an ethernet driver that I
have using ioctl's. The ethernet ioctl interface is slightly different
from a "normal" ioctl in that it uses sockets and not a file descriptor.
The ioctl's I use are added to the ioctl interface in the driver, using
the defined device-specific range (that was supposed to disappear in
2.5.x or 2.6.x). With this I read/write my phy register's to test out
the interface between my TEMAC and my PHY.=20

#include <sys/types.h>
#include <sys/ioctl.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <net/if.h>
#include <linux/sockios.h>

int main (int argc, char **argv)
{
   int   driver_fd =3D -1;
   int   cmd       =3D 0;
   int   res;
   char* buffer    =3D NULL;
   struct ifreq ifr;

   if (argc < 3)
   {
      printf ("Usage %s <devname> <ioctl>\n", argv [0]);
      exit (1);
   }

   driver_fd =3D socket(AF_INET, SOCK_DGRAM, 0);
   if (driver_fd =3D=3D -1)
   {
      printf ("Could not open %s: %s\n", TEMAC_DRIVER_NAME, strerror
(errno));
      exit (1);
   }

   memset(&ifr, 0, sizeof(struct ifreq));
   strcpy(ifr.ifr_name, argv[1]);

   cmd =3D atoi (argv [2]);
   if (SIOCDEVPRIVATE + 3 =3D=3D cmd) {
      if (argc !=3D 4) {
         printf("usage %s <devname> 35315 <phy reg>\n", argv[0]);
         exit(1);
      }

      ifr.ifr_ifindex =3D atoi(argv[3]);
   }
   if (SIOCDEVPRIVATE + 4 =3D=3D cmd) {
      if (argc !=3D 5) {
         printf("usage %s <devname> 35316 <phy reg> <val>\n", argv[0]);
         exit(1);
      }

      ifr.ifr_ifindex =3D atoi(argv[3]) << 16;
      ifr.ifr_ifindex |=3D atoi(argv[4]);
   }
   printf("Performing ioctl %d:\n", cmd);

   res =3D ioctl(driver_fd, cmd, &ifr);

   if (res =3D=3D -1)
   {
      printf ("Error from %d: %s\n", driver_fd, strerror (errno));
      exit (1);
   }

   return 0;
}

-----Original Message-----
From: John Linn [mailto:John.Linn@xilinx.com]=20
Sent: Thursday, March 06, 2008 5:15 PM
To: khollan; linuxppc-embedded@ozlabs.org
Subject: RE: Xilinx Temac link detect

Hi Kevin,

I couldn't find any example laying around, so I took a shot at it based
on other non-network examples we had. I've not personally done it so
bear that in mind.

I have not tried to compile any of this, just stole parts for places and
pasted in.

Hope it helps,
John

#include <ioctl.h>

	/*
 	 * FD of the IIC device opened.
 	 */
	int Fdtemac;

	struct mii_ioctl_data ioctl_data;=09

	/*
	 * Open the device.
	 */
	Fdtemac =3D open("/dev/TBD", O_RDWR);
	if(Fdtemac < 0)
	{
		printf("Cannot open the temac device\n");
		return -1;
	}

	/* setup the inputs to the ioctl call */

	ioctl_data.phy_num =3D TBD;
	ioctl_data.reg_num =3D TBD;
=09
	/*
	 * Read the phy register
	 */
	Register =3D ioctl(Fdtemac, SIOCGMIIREG, &ioctl_data);
	if(Status < 0)
	{
		/* failure */
		return 0;
	}

	/* results should be in ioctl_data.val_out I think

}

>From the temac linux adapter, a snippet showing the the ioctl function.

xenet_ioctl(struct net_device *dev, struct ifreq *rq, int cmd) {
    struct mii_ioctl_data *data =3D (struct mii_ioctl_data *)
&rq->ifr_data;

    case SIOCGMIIREG:   /* Read GMII PHY register. */
        ret =3D XTemac_PhyRead(&lp->Emac, data->phy_id,
                       data->reg_num, &data->val_out); }

from linux/mii.h

/* This structure is used in all SIOCxMIIxxx ioctl calls */ struct
mii_ioctl_data {
	__u16		phy_id;
	__u16		reg_num;
	__u16		val_in;
	__u16		val_out;
};

from linux/if.h

struct ifreq
{
#define IFHWADDRLEN	6
	union
	{
		char	ifrn_name[IFNAMSIZ];		/* if name, e.g.
"en0" */
	} ifr_ifrn;
=09
	union {
		struct	sockaddr ifru_addr;
		struct	sockaddr ifru_dstaddr;
		struct	sockaddr ifru_broadaddr;
		struct	sockaddr ifru_netmask;
		struct  sockaddr ifru_hwaddr;
		short	ifru_flags;
		int	ifru_ivalue;
		int	ifru_mtu;
		struct  ifmap ifru_map;
		char	ifru_slave[IFNAMSIZ];	/* Just fits the size */
		char	ifru_newname[IFNAMSIZ];
		void __user *	ifru_data;
		struct	if_settings ifru_settings;
	} ifr_ifru;
};

-----Original Message-----
From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org] On
Behalf Of khollan
Sent: Thursday, March 06, 2008 1:44 PM
To: linuxppc-embedded@ozlabs.org
Subject: Re: Xilinx Temac link detect



I figure I could write a C program to talk to the ioctl in the TEMAC
driver and read the PHY register.  Does anyone have example code for
talking to network ioctl's?

Thanks

Kevin
--
View this message in context:
http://www.nabble.com/Xilinx-Temac-link-detect-tp15616042p15883376.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
