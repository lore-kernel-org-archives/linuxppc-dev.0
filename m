Return-Path: <scott.coulter@cyclone.com>
Received: from CYBORG3.cyclone.com (cyborg3.cyclone.com [69.37.28.78])
	by ozlabs.org (Postfix) with ESMTP id 46FB3DDDA1
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 07:45:05 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Gianfar tx-babbling-errors
Date: Wed, 18 Feb 2009 15:45:04 -0500
Message-ID: <43EB80E07C42E1408726E4905FB96B04C076CC@CYBORG3.cyclone.com>
In-Reply-To: <6BBF4AB4-FFB0-46ED-B591-17DEC3BE547F@kernel.crashing.org>
References: <43EB80E07C42E1408726E4905FB96B04C0769D@CYBORG3.cyclone.com>
	<F122E3A2-3054-4BC9-9C06-0ADE590A8AFC@kernel.crashing.org>
	<43EB80E07C42E1408726E4905FB96B04C076B1@CYBORG3.cyclone.com>
	<6BBF4AB4-FFB0-46ED-B591-17DEC3BE547F@kernel.crashing.org>
From: "Scott Coulter" <scott.coulter@cyclone.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Kumar,

>=20
> can't think of any.  How about adding a BUG_ON() in the tx path to see
> if the buffer size > MTU and re-run your tests.
>

With the following in gfar_start_xmit():

BUG_ON(skb->len > priv->dev->mtu);

I bug checked during the NFS root boot process with skb->len at 1514 and
priv->dev->mtu at 1500.  I changed it to:

BUG_ON(skb->len > DEFAULT_RX_BUFFER_SIZE);

Compiling now.  Has not failed yet, I'll let you know.

Scott

___________________________________________________________________

  Scott N. Coulter
  Senior Software Engineer
 =20
  Cyclone Microsystems         =20
  370 James Street              Phone:  203.786.5536 ext. 118
  New Haven, CT 06513-3051      Email:  scott.coulter@cyclone.com
  U.S.A.                        Web:    http://www.cyclone.com
___________________________________________________________________
