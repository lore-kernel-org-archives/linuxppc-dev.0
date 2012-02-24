Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe005.messaging.microsoft.com
 [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 83DF1B6F62
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Feb 2012 10:26:06 +1100 (EST)
Message-ID: <4F481C83.4060206@freescale.com>
Date: Fri, 24 Feb 2012 17:25:55 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <b04825@freescale.com>
Subject: Re: warnings from drivers/tty/ehv_bytechan.c
References: <20120220072352.4c8131bbcea69afc007a4297@canb.auug.org.au>
 <4F424985.2020706@freescale.com> <20120224215008.GB25330@kroah.com>
 <4F48086C.5010407@freescale.com> <20120224220623.GA29400@kroah.com>
 <4F480BE8.9080606@freescale.com>
In-Reply-To: <4F480BE8.9080606@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/24/2012 04:15 PM, Timur Tabi wrote:
> gregkh@linuxfoundation.org wrote:
>>>> That's the simplest approach, for use.  The TTY portion of the driver can
>>>> be used as a module.  Is there any real value in loading a TTY driver as a
>>>> module?
> 
>> Depends on the hardware it supports :)
>>
>>>> In this case, the console support for byte channels would not be
>>>> available.
> 
>> Then it doesn't make sense, right?
> 
> I guess that's my question.  Is there a real use case for having console
> output go to the serial port, and TTY go to a byte channel?

Sure -- you could be using the byte channel for inter-partition
communication, or just not have enough serial ports for all of this
partition's needs.

It looks like the usual pattern is to have a separate kconfig for the
console part, and have that be a bool that depends on the tristate tty
driver being "y".

> Even if you
> wanted to do that, I supposed you don't need to load the byte channel
> driver as a module to get that behavior.

Right, though that could be said about all (most?) modules.

Probably not that important in this particular case, though.  I can see
people wanting to use byte channel but not caring about console, and I
can see people wanting to build a generic kernel that supports byte
channels, but I don't think there's much overlap between the two.

-Scott
