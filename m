Return-Path: <John.Linn@xilinx.com>
Received: from outbound9-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 04A7DDDFB0
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Mar 2008 09:15:48 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Xilinx Temac link detect
Date: Thu, 6 Mar 2008 15:14:44 -0700
In-Reply-To: <15883376.post@talk.nabble.com>
References: <15616042.post@talk.nabble.com> <15883376.post@talk.nabble.com>
From: "John Linn" <John.Linn@xilinx.com>
To: "khollan" <khollan@daktronics.com>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20080306221446.4509A1118051@mail123-sin.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

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

xenet_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
{
    struct mii_ioctl_data *data =3D (struct mii_ioctl_data *)
&rq->ifr_data;

    case SIOCGMIIREG:   /* Read GMII PHY register. */
        ret =3D XTemac_PhyRead(&lp->Emac, data->phy_id,
                       data->reg_num, &data->val_out);
}

from linux/mii.h

/* This structure is used in all SIOCxMIIxxx ioctl calls */
struct mii_ioctl_data {
	__u16		phy_id;
	__u16		reg_num;
	__u16		val_in;
	__u16		val_out;
};

from linux/if.h

struct ifreq=20
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
driver
and read the PHY register.  Does anyone have example code for talking to
network ioctl's?

Thanks

Kevin
--=20
View this message in context:
http://www.nabble.com/Xilinx-Temac-link-detect-tp15616042p15883376.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
