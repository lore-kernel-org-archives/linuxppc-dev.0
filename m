Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVpfT5fJNzDrKc
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 21:27:44 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'David Miller' <davem@davemloft.net>, "desnesn@linux.vnet.ibm.com"
 <desnesn@linux.vnet.ibm.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "tlfalcon@linux.vnet.ibm.com" <tlfalcon@linux.vnet.ibm.com>,
 "nfont@linux.vnet.ibm.com" <nfont@linux.vnet.ibm.com>,
 "jallen@linux.vnet.ibm.com" <jallen@linux.vnet.ibm.com>
Subject: RE: [PATCH] [net-next,v2] ibmvnic: Feature implementation of Vital
 Product Data (VPD) for the ibmvnic driver
Date: Mon, 6 Nov 2017 10:27:55 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD00B1167@AcuExch.aculab.com>
References: <20171101210332.7278-1-desnesn@linux.vnet.ibm.com>
 <20171104.222107.1124370080560433601.davem@davemloft.net>
In-Reply-To: <20171104.222107.1124370080560433601.davem@davemloft.net>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: David Miller
> Sent: 04 November 2017 13:21
> From: Desnes Augusto Nunes do Rosario <desnesn@linux.vnet.ibm.com>
> Date: Wed,  1 Nov 2017 19:03:32 -0200
>=20
> > +	substr =3D strnstr(adapter->vpd->buff, "RM", adapter->vpd->len);
> > +	if (!substr) {
> > +		dev_info(dev, "No FW level provided by VPD\n");
> > +		complete(&adapter->fw_done);
> > +		return;
> > +	}
> > +
> > +	/* get length of firmware level ASCII substring */
> > +	fw_level_len =3D *(substr + 2);
> > +
> > +	/* copy firmware version string from vpd into adapter */
> > +	ptr =3D strncpy((char *)adapter->fw_version,
> > +		      substr + 3, fw_level_len);
>=20
> You have to be more careful here, making sure first that
> (substr + 2) < (adapter->vpd->buff + adapter->vpd->len),
> and next that (substr + 2 + fw_level_len) is in range
> as well.

And that the copy isn't longer than the target buffer.

	David
