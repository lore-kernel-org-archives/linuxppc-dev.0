Return-Path: <bwarren@qstreams.com>
Received: from smtp102.biz.mail.re2.yahoo.com (smtp102.biz.mail.re2.yahoo.com
	[68.142.229.216]) by ozlabs.org (Postfix) with SMTP id 18FDBDDDEB
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 13 Oct 2007 05:55:09 +1000 (EST)
Message-ID: <470FCF8A.1000504@qstreams.com>
Date: Fri, 12 Oct 2007 15:48:26 -0400
From: Ben Warren <bwarren@qstreams.com>
MIME-Version: 1.0
To: Michael Brian Willis <willis@arlut.utexas.edu>
Subject: Re: MPC85xx and linux IDE driver
References: <1192213784.4862.48.camel@louie>
In-Reply-To: <1192213784.4862.48.camel@louie>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Michael Brian Willis wrote:
> Hello, 
>
> I am using an MPC8540 based embedded system with a Compact Flash card in
> true IDE mode. The Compact Flash card is directly connected to the
> MPC8540 bus without the use of a pcmcia adapter. 
>
> The Compact Flash card is being initialized correctly using the U-boot
> boot-loader and is working properly as an ide device in U-boot. However
> I cannot get linux to recognize the ide device.
>
> I have tried several different linux config options and have tried
> passing kernel command line options as advised in the
> Documentation/ide.txt help file. However I have not been able to get the
> kernel to recognize my ide device. 
>
> Does anybody know if I can use the generic linux ide drivers? Or will I
> need to modify/write my own driver for this type of setup? 
>   
Here's what I use:

http://marc.info/?l=linux-kernel&m=113877891224982&w=2

Please note that if you're using a kernel newer than 2.6.18, the _insw() 
and _outsw() calls no longer exist, so you'll need to replace them. 
Here's how I modified Kumar's functions. Not necessarily the right way, 
but it seems to work:

/* xxx: use standard outsw, insw when byte lanes swapped */
static void cfide_outsw(unsigned long port, void *addr, u32 count)
{
u16 *tmp = addr;
while (count--)
out_le16((u16 *)port, *tmp++);
}

static void cfide_insw(unsigned long port, void *addr, u32 count)
{
u16 *tmp = addr;
while (count--)
*tmp++ = in_le16((u16 *)port);
}


regards,
Ben
