Return-Path: <bgat@billgatliff.com>
Received: from mail-yx0-f172.google.com (mail-yx0-f172.google.com
	[209.85.210.172]) by ozlabs.org (Postfix) with ESMTP id B8A59B7DA2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Apr 2010 23:00:42 +1000 (EST)
Received: by yxe2 with SMTP id 2so897648yxe.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Apr 2010 06:00:40 -0700 (PDT)
Message-ID: <4BC70E47.9010408@billgatliff.com>
Date: Thu, 15 Apr 2010 08:01:59 -0500
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Roman Fietze <roman.fietze@telemotive.de>
Subject: Re: Xorg on Fujitsu "Lime" with MPC5200b?
References: <4BC682DC.1050200@billgatliff.com>
	<201004150921.47268.roman.fietze@telemotive.de>
In-Reply-To: <201004150921.47268.roman.fietze@telemotive.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Roman Fietze wrote:
> Hallo Bill,
>
> On Thursday 15 April 2010 05:07:08 Bill Gatliff wrote:
>
>   
>> Actually, I *have* Debian squeeze's xorg running on the platform just
>> fine, with a 2.6.34-rc1 kernel (kernel.org).  Problem is, every single
>> diagonal line is very blocky--- not smooth at all.
>>     
>
> I'm 95% sure it's an endianess problem, on our boards we had to modify
> the X11 driver. What I did was swapping bytes when updating the device
> from the shadowfb inside programs/Xserver/miext/shadow/shpacked.c
>   

Are you talking about this code here?

    void
    shadowUpdatePacked (ScreenPtr pScreen,
                        shadowBufPtr pBuf)
    {
    ...
                    while (i--)
                        *win++ = *sha++;



Do I endian-swap each *sha?  Or, do I reorder the sha array before
dereferencing it (e.g. each *sha is right, but adjacent ones are in the
wrong order)?


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com
