Date: Tue, 16 Oct 2001 03:47:41 -0700
From: Till Straumann <Till.Straumann@TU-Berlin.de>
Subject: IRDA/IRCOMM on a TiBook patch
To: linuxppc-dev@lists.linuxppc.org, linux-irda@pasta.cs.uit.no
Message-id: <3BCC104D.B5770ADE@TU-Berlin.de>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_eecReCwHkZq23LceQWbRCQ)"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dies ist eine mehrteilige Nachricht im MIME-Format.

--Boundary_(ID_eecReCwHkZq23LceQWbRCQ)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT

Hi all.

I (and I believe other people as well) had problems
setting up IRDA/IRCOMM on a TiBook / 2.4.12-benh and
older 2.4 series kernels [on powerpc].

As far as I could find out there are several problems:

1) There seems to be a timing problem when opening
   the irda port which prevents it from being properly
   initialized.

   When I run "irattach /dev/ttyS1 -s 1", my Nokia 8890
   is never discovered. However, when I issue a 'cat /dev/ttyS1',
   prior to starting irattach (i.e. by opening the device
   [and holding it open until irattach starts]),
   things are properly initialized
   and discovery works. Putting 'mdelay(100);' somewhere
   in macserial.c:rs_open() does the job. However, I have
   not yet figured out what exactly causes the problem.
   A user space work-around involves patching irattach.c

2) There is an endianness bug. A possible solution is attached.

3) When applying 1) and 2), IRCOMM works provided that
   /proc/sys/net/irda/max_baud_rate is clamped to 57600.
   Apparently, there is another problem in 'macserial.c' where speeds
   higher than 57600 are treated especially.

Has somebody out there investigated on this?

-- Till.

PS: I'm not on this mailing list, please CC

--Boundary_(ID_eecReCwHkZq23LceQWbRCQ)
Content-type: text/plain; charset=us-ascii; name=irattach.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=irattach.patch

*** irattach.c.orig	Tue Oct 16 03:32:01 2001
--- irattach.c	Tue Oct 16 03:34:56 2001
***************
*** 270,275 ****
--- 270,280 ----
  		syslog(LOG_ERR, "Failed to open %s: %m", dev);
  		exit(1);
  	}
+ 	/* T. Straumann, 10/2001: <strauman@slac.stanford.edu>
+ 	 *    Wait a little to work around a problem on the
+ 	 *    Apple TiBook...
+ 	 */
+ 	sleep(1);
  	if ((initfdflags = fcntl(fd, F_GETFL)) == -1) {
  		syslog(LOG_ERR, "Couldn't get device fd flags: %m");
  		exit(1);

--Boundary_(ID_eecReCwHkZq23LceQWbRCQ)
Content-type: text/plain; charset=us-ascii; name=irda.tillpatch0
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=irda.tillpatch0

This patch against linux-2.4.12-benh0
fixes an endianness problem on the PPC
for IRDA.

To apply this patch, chdir to the linux
source topdir and issue

patch -p0 < 'this_file'

Till Straumann <strauman@slac.stanford.edu>, 10/2001

*** ./include/net/irda/parameters.h.orig	Mon Oct 15 00:50:17 2001
--- ./include/net/irda/parameters.h	Tue Oct 16 00:05:22 2001
***************
*** 25,30 ****
--- 25,33 ----
   *     along with this program; if not, write to the Free Software
   *     Foundation, Inc., 59 Temple Place, Suite 330, Boston,
   *     MA 02111-1307 USA
+  *
+  *     Till Straumann, <Till.Straumann@TU-Berlin.de>, 10/2001
+  *     - fixed endianness of irda_pv_t
   *
   ********************************************************************/

***************
*** 53,67 ****
  #define PV_PUT 0
  #define PV_GET 1

  typedef union {
  	char   *c;
! 	__u8    b;
! 	__u16   s;
  	__u32   i;
  	__u8  *bp;
  	__u16 *sp;
  	__u32 *ip;
  } irda_pv_t;

  typedef struct {
  	__u8 pi;
--- 56,92 ----
  #define PV_PUT 0
  #define PV_GET 1

+ #if   defined(__BIG_ENDIAN) 	/* TODO: not 64bit safe (when casting __u32 to ptr) */
  typedef union {
  	char   *c;
! 	struct {
! 	__u8    mm,ml,lm,ll;	/* most to least significant */
! 	}       b;
! 	struct {
! 	__u16   m,l;		/* most to least significant */
! 	}       s;
  	__u32   i;
  	__u8  *bp;
  	__u16 *sp;
  	__u32 *ip;
  } irda_pv_t;
+ #elif defined(__LITTLE_ENDIAN) 	/* TODO: not 64bit safe */
+ typedef union {
+ 	char   *c;
+ 	struct {
+ 	__u8    ll,lm,ml,mm;	/* least to most significant */
+ 	}       b;
+ 	struct {
+ 	__u16   l,m;		/* least to most significant */
+ 	}       s;
+ 	__u32   i;
+ 	__u8  *bp;
+ 	__u16 *sp;
+ 	__u32 *ip;
+ } irda_pv_t;
+ #else
+ #error "unknown endianness"
+ #endif

  typedef struct {
  	__u8 pi;
*** ./net/irda/ircomm/ircomm_param.c.orig	Mon Oct 15 01:03:54 2001
--- ./net/irda/ircomm/ircomm_param.c	Mon Oct 15 01:04:47 2001
***************
*** 182,194 ****
  				     int get)
  {
  	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) instance;
! 	__u8 service_type = param->pv.b; /* We know it's a one byte integer */

  	ASSERT(self != NULL, return -1;);
  	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return -1;);

  	if (get) {
! 		param->pv.b = self->settings.service_type;
  		return 0;
  	}

--- 182,194 ----
  				     int get)
  {
  	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) instance;
! 	__u8 service_type = param->pv.b.ll; /* We know it's a one byte integer */

  	ASSERT(self != NULL, return -1;);
  	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return -1;);

  	if (get) {
! 		param->pv.b.ll = self->settings.service_type;
  		return 0;
  	}

***************
*** 246,254 ****
  	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return -1;);

  	if (get)
! 		param->pv.b = IRCOMM_SERIAL;
  	else {
! 		self->settings.port_type = param->pv.b;

  		IRDA_DEBUG(0, __FUNCTION__ "(), port type=%d\n",
  			   self->settings.port_type);
--- 246,254 ----
  	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return -1;);

  	if (get)
! 		param->pv.b.ll = IRCOMM_SERIAL;
  	else {
! 		self->settings.port_type = param->pv.b.ll;

  		IRDA_DEBUG(0, __FUNCTION__ "(), port type=%d\n",
  			   self->settings.port_type);
***************
*** 317,325 ****
  	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return -1;);

  	if (get)
! 		param->pv.b = self->settings.data_format;
  	else
! 		self->settings.data_format = param->pv.b;

  	return 0;
  }
--- 317,325 ----
  	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return -1;);

  	if (get)
! 		param->pv.b.ll = self->settings.data_format;
  	else
! 		self->settings.data_format = param->pv.b.ll;

  	return 0;
  }
***************
*** 339,349 ****
  	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return -1;);

  	if (get)
! 		param->pv.b = self->settings.flow_control;
  	else
! 		self->settings.flow_control = param->pv.b;

! 	IRDA_DEBUG(1, __FUNCTION__ "(), flow control = 0x%02x\n", param->pv.b);

  	return 0;
  }
--- 339,349 ----
  	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return -1;);

  	if (get)
! 		param->pv.b.ll = self->settings.flow_control;
  	else
! 		self->settings.flow_control = param->pv.b.ll;

! 	IRDA_DEBUG(1, __FUNCTION__ "(), flow control = 0x%02x\n", param->pv.b.ll);

  	return 0;
  }
***************
*** 362,376 ****
  	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return -1;);

  	if (get) {
! 		param->pv.s = self->settings.xonxoff[0];
! 		param->pv.s |= self->settings.xonxoff[1] << 8;
  	} else {
! 		self->settings.xonxoff[0] = param->pv.s & 0xff;
! 		self->settings.xonxoff[1] = param->pv.s >> 8;
  	}

  	IRDA_DEBUG(0, __FUNCTION__ "(), XON/XOFF = 0x%02x,0x%02x\n",
! 		   param->pv.s & 0xff, param->pv.s >> 8);

  	return 0;
  }
--- 362,376 ----
  	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return -1;);

  	if (get) {
! 		param->pv.s.l = self->settings.xonxoff[0];
! 		param->pv.s.l |= self->settings.xonxoff[1] << 8;
  	} else {
! 		self->settings.xonxoff[0] = param->pv.s.l & 0xff;
! 		self->settings.xonxoff[1] = param->pv.s.l >> 8;
  	}

  	IRDA_DEBUG(0, __FUNCTION__ "(), XON/XOFF = 0x%02x,0x%02x\n",
! 		   param->pv.s.l & 0xff, param->pv.s.l >> 8);

  	return 0;
  }
***************
*** 389,403 ****
  	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return -1;);

  	if (get) {
! 		param->pv.s = self->settings.enqack[0];
! 		param->pv.s |= self->settings.enqack[1] << 8;
  	} else {
! 		self->settings.enqack[0] = param->pv.s & 0xff;
! 		self->settings.enqack[1] = param->pv.s >> 8;
  	}

  	IRDA_DEBUG(0, __FUNCTION__ "(), ENQ/ACK = 0x%02x,0x%02x\n",
! 		   param->pv.s & 0xff, param->pv.s >> 8);

  	return 0;
  }
--- 389,403 ----
  	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return -1;);

  	if (get) {
! 		param->pv.s.l = self->settings.enqack[0];
! 		param->pv.s.l |= self->settings.enqack[1] << 8;
  	} else {
! 		self->settings.enqack[0] = param->pv.s.l & 0xff;
! 		self->settings.enqack[1] = param->pv.s.l >> 8;
  	}

  	IRDA_DEBUG(0, __FUNCTION__ "(), ENQ/ACK = 0x%02x,0x%02x\n",
! 		   param->pv.s.l & 0xff, param->pv.s.l >> 8);

  	return 0;
  }
***************
*** 431,439 ****
  	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return -1;);

  	if (get)
! 		param->pv.b = self->settings.dte;
  	else {
! 		dte = param->pv.b;

  		if (dte & IRCOMM_DELTA_DTR)
  			self->settings.dce |= (IRCOMM_DELTA_DSR|
--- 431,439 ----
  	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return -1;);

  	if (get)
! 		param->pv.b.ll = self->settings.dte;
  	else {
! 		dte = param->pv.b.ll;

  		if (dte & IRCOMM_DELTA_DTR)
  			self->settings.dce |= (IRCOMM_DELTA_DSR|
***************
*** 470,478 ****
  	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) instance;
  	__u8 dce;

! 	IRDA_DEBUG(1, __FUNCTION__ "(), dce = 0x%02x\n", param->pv.b);

! 	dce = param->pv.b;

  	ASSERT(self != NULL, return -1;);
  	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return -1;);
--- 470,478 ----
  	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) instance;
  	__u8 dce;

! 	IRDA_DEBUG(1, __FUNCTION__ "(), dce = 0x%02x\n", param->pv.b.ll);

! 	dce = param->pv.b.ll;

  	ASSERT(self != NULL, return -1;);
  	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return -1;);
*** ./net/irda/parameters.c.orig	Fri Oct 12 05:04:55 2001
--- ./net/irda/parameters.c	Mon Oct 15 01:16:28 2001
***************
*** 167,180 ****
  	IRDA_DEBUG(2, __FUNCTION__ "(), pi=%#x, pl=%d, pi=%d\n", p.pi, p.pl, p.pv.i);
  	switch (p.pl) {
  	case 1:
! 		n += irda_param_pack(buf, "bbb", p.pi, p.pl, p.pv.b);
  		break;
  	case 2:
  		if (type & PV_BIG_ENDIAN)
! 			cpu_to_be16s(&p.pv.s);
  		else
! 			cpu_to_le16s(&p.pv.s);
! 		n += irda_param_pack(buf, "bbs", p.pi, p.pl, p.pv.s);
  		break;
  	case 4:
  		if (type & PV_BIG_ENDIAN)
--- 167,180 ----
  	IRDA_DEBUG(2, __FUNCTION__ "(), pi=%#x, pl=%d, pi=%d\n", p.pi, p.pl, p.pv.i);
  	switch (p.pl) {
  	case 1:
! 		n += irda_param_pack(buf, "bbb", p.pi, p.pl, p.pv.b.ll);
  		break;
  	case 2:
  		if (type & PV_BIG_ENDIAN)
! 			cpu_to_be16s(&p.pv.s.l);
  		else
! 			cpu_to_le16s(&p.pv.s.l);
! 		n += irda_param_pack(buf, "bbs", p.pi, p.pl, p.pv.s.l);
  		break;
  	case 4:
  		if (type & PV_BIG_ENDIAN)
***************
*** 230,245 ****
  		return p.pl+2;
  	}

  	switch (p.pl) {
  	case 1:
! 		n += irda_param_unpack(buf+2, "b", &p.pv.b);
  		break;
  	case 2:
! 		n += irda_param_unpack(buf+2, "s", &p.pv.s);
  		if (type & PV_BIG_ENDIAN)
! 			be16_to_cpus(&p.pv.s);
  		else
! 			le16_to_cpus(&p.pv.s);
  		break;
  	case 4:
  		n += irda_param_unpack(buf+2, "i", &p.pv.i);
--- 230,246 ----
  		return p.pl+2;
  	}

+
  	switch (p.pl) {
  	case 1:
! 		n += irda_param_unpack(buf+2, "b", &p.pv.b.ll);
  		break;
  	case 2:
! 		n += irda_param_unpack(buf+2, "s", &p.pv.s.l);
  		if (type & PV_BIG_ENDIAN)
! 			be16_to_cpus(&p.pv.s.l);
  		else
! 			le16_to_cpus(&p.pv.s.l);
  		break;
  	case 4:
  		n += irda_param_unpack(buf+2, "i", &p.pv.i);
***************
*** 255,260 ****
--- 256,262 ----
  		return p.pl+2;
  	}

+ 	IRDA_DEBUG(2, __FUNCTION__ "(), pi=%#x, pl=%d, pi=%d\n", p.pi, p.pl, p.pv.i);
  	/* Call handler for this parameter */
  	err = (*func)(self, &p, PV_PUT);
  	if (err < 0)
***************
*** 359,366 ****
  			buf[n++] = (__u8)va_arg(args, int);
  			break;
  		case 's':  /* 16 bits unsigned short */
! 			arg.s = (__u16)va_arg(args, int);
! 			put_unaligned(arg.s, (__u16 *)(buf+n)); n+=2;
  			break;
  		case 'i':  /* 32 bits unsigned integer */
  			arg.i = va_arg(args, __u32);
--- 361,368 ----
  			buf[n++] = (__u8)va_arg(args, int);
  			break;
  		case 's':  /* 16 bits unsigned short */
! 			arg.s.l = (__u16)va_arg(args, int);
! 			put_unaligned(arg.s.l, (__u16 *)(buf+n)); n+=2;
  			break;
  		case 'i':  /* 32 bits unsigned integer */
  			arg.i = va_arg(args, __u32);

--Boundary_(ID_eecReCwHkZq23LceQWbRCQ)--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
