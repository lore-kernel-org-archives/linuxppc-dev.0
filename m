Return-Path: <michael@ellerman.id.au>
Message-ID: <1389154189.2076.5.camel@concordia>
Subject: Re: [PATCH] powerpc: Fix alignment of secondary cpu spin vars
From: Michael Ellerman <michael@ellerman.id.au>
To: Olof Johansson <olof@lixom.net>
Date: Wed, 08 Jan 2014 15:09:49 +1100
In-Reply-To: <20140103081219.GA10233@quad.lixom.net>
References: <1388264507-5100-1-git-send-email-olof@lixom.net>
 <CAOesGMhHw-G-T7ZfNsVU92ftOucCNe9shNJtA7SWzqX=dQBQng@mail.gmail.com>
 <CAOesGMgsY0R6KBXXH_ibTBYb1i_auWESwnoDkvi-esb58Pc+2A@mail.gmail.com>
 <20140103081219.GA10233@quad.lixom.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Anton Blanchard <anton@samba.org>, chzigotzky@xenosoft.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-01-03 at 00:12 -0800, Olof Johansson wrote:
> On Thu, Jan 02, 2014 at 11:56:04PM -0800, Olof Johansson wrote:
> 
> > This makes things interesting though. The BE/LE trampoline code
> > assumes at least 3 consecutive instructions. What was the reasoning
> > behind entering the kernel LE instead of keeping the old boot protocol
> > and just switching to LE once kernel is loaded? Is it actually used on
> > some platforms or is this just a theoretical thing?
> 
> Actually, adding a little hack that zeroes out the memory once we're done
> executing it will work just fine too. I know this is sort of icky, but maybe
> it'll be good enough for now?
> 
> Of course, main worry is that this is just hiding some latent NULL deref in
> the kernel now... :-/

Wow, that would have to come close to winning the grossest-hack-in-arch-powerpc
award :)

Have you tried changing the value at 8 to point to a reserved page?

Some other possibilities:

 * Change the #define so FIXUP_ENDIAN is empty for PASEMI, that would mean
   you'd only be able to boot pasemi_defconfig.
 * Move the hack into FIXUP_ENDIAN

cheers
