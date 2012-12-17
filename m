Return-Path: <anton@samba.org>
Date: Mon, 17 Dec 2012 22:33:33 +1100
From: Anton Blanchard <anton@samba.org>
To: Jimi Xenidis <jimix@pobox.com>
Subject: Re: [PATCH] powerpc: POWER7 optimised memcpy using VMX and enhanced
 prefetch
Message-ID: <20121217223333.6cb00476@kryten>
In-Reply-To: <D5CF6D4A-8F60-4853-9F7C-EFE5133CEB33@pobox.com>
References: <20120531162209.04bd9bdc@kryten>
 <D5CF6D4A-8F60-4853-9F7C-EFE5133CEB33@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Kumar Gala <kumar.gala@gmail.com>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Jimi,

> I know this is a little late, but shouldn't these power7 specific
> thingies be in "obj-$(CONFIG_PPC_BOOK3S_64)". The reason I ask is
> that my compiler pukes on "dcbtst" and as I deal with that I wanted
> to point this out.

I guess we could do that. It's a bit strange your assembler is
complaining about the dcbtst instructions since we wrap them with
power4:

.machine push
.machine "power4"
        dcbt    r0,r4,0b01000
        dcbt    r0,r7,0b01010
        dcbtst  r0,r9,0b01000
        dcbtst  r0,r10,0b01010
        eieio
        dcbt    r0,r8,0b01010   /* GO */
.machine pop

Anton
