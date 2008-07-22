Return-Path: <neko@genesi-usa.com>
Received: from hu-out-0506.google.com (hu-out-0506.google.com [72.14.214.224])
	by ozlabs.org (Postfix) with ESMTP id B2F02DE0C1
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 19:05:32 +1000 (EST)
Received: by hu-out-0506.google.com with SMTP id 34so7306516hue.9
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 02:05:30 -0700 (PDT)
Message-ID: <4885A2C2.4060603@genesi-usa.com>
Date: Tue, 22 Jul 2008 10:05:06 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: =?UTF-8?B?TWljaGVsIETDpG56ZXI=?= <michel@tungstengraphics.com>
Subject: Re: radeonfb, dedicate memory to something else
References: <48830D56.2080704@genesi-usa.com>	
	<9e4733910807200826m22b676aewa89de8df9fd6da33@mail.gmail.com>	
	<48859AD2.6050404@genesi-usa.com>
	<1216716723.15900.128.camel@thor.sulgenrain.local>
In-Reply-To: <1216716723.15900.128.camel@thor.sulgenrain.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michel Dänzer wrote:
> On Tue, 2008-07-22 at 09:31 +0100, Matt Sealey wrote:
>> or other graphics drivers can be told "please only use the first 32MB" and
>> then either manually or automatically, map the rest as ramdisk.
> 
> You can limit the amount of video RAM used by X using the VideoRam
> directive in xorg.conf(5).

Ah okay. So now.. how do we do this for framebuffers?

Is it safe to poke around in radeon_identify_vram and maybe supply a kernel
argument videomem=32M and let it check, if it's bigger, then limit it, and
if not, keep the old size in rinfo->video_ram?

Can/could this be moved to all relevant framebuffer drivers?

> GART doesn't have anything to do with this. I suspect he was thinking of
> the PCI BARs not covering all video RAM.

That's certainly not the case here.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
