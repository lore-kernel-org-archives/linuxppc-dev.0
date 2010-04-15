Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 40892B7C48
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Apr 2010 23:53:59 +1000 (EST)
From: Roman Fietze <roman.fietze@telemotive.de>
To: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: Xorg on Fujitsu "Lime" with MPC5200b?
References: <4BC682DC.1050200@billgatliff.com>
	<201004150921.47268.roman.fietze@telemotive.de>
	<4BC70E47.9010408@billgatliff.com>
In-Reply-To: <4BC70E47.9010408@billgatliff.com>
MIME-Version: 1.0
Message-ID: <201004151553.53426.roman.fietze@telemotive.de>
Date: Thu, 15 Apr 2010 15:53:53 +0200
Content-Type: Text/Plain;
  charset="iso-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Bill,

On Thursday 15 April 2010 15:01:59 Bill Gatliff wrote:

> Are you talking about this code here?
>=20
>     void
>     shadowUpdatePacked (ScreenPtr pScreen,
>                         shadowBufPtr pBuf)
>     {
>     ...
>                     while (i--)
>                         *win++ =3D *sha++;

Yes. I added a routine like

/* Swap frame buffer bytes in 32 bit value.  */
static __inline unsigned int
fbbits_swap32(unsigned int __bsx)
{
    return ((((__bsx) & 0xff000000) >> 8) | (((__bsx) & 0x00ff0000) << 8) |
	    (((__bsx) & 0x0000ff00) >> 8) | (((__bsx) & 0x000000ff) << 8));
}


Then I added void shadowUpdatePackedSwapped16() and
shadowUpdatePackedSwapped32() which I was using instead of the
original *Weak functions, which in turn uses the above swap routine
when copying from shadow to the device.

If you want I can post (in the ML) or mail you the files that I
changed. A diff probably won't help a lot, because I think we changed
more than that, and we are using a pretty old XFree version.


Roman

=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
