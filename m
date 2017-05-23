Return-Path: <jk@ozlabs.org>
Subject: Re: SPU not working for kernel 4.9, 4.10, 4.11a and 4.12
From: Jeremy Kerr <jk@ozlabs.org>
To: Sombat Tragolgosol <sombat3960@gmail.com>, Linuxppc-dev@lists.ozlabs.org
Cc: geoff@infradead.org
References: <CAC1vu621cqMcucgMGF9AvW2VVBFDNbqbW2ZPkuFRRHWjO58CFQ@mail.gmail.com>
 <c16c0ba8-aa6d-0dbd-28d2-d73fda643ae5@ozlabs.org>
Message-ID: <32cc4462-0a47-ee5a-7429-af5428126743@ozlabs.org>
Date: Tue, 23 May 2017 18:01:34 +1000
MIME-Version: 1.0
In-Reply-To: <c16c0ba8-aa6d-0dbd-28d2-d73fda643ae5@ozlabs.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,


> Looks like this also happens with the simple spu_run test:
> 
>  https://github.com/jk-ozlabs/spufs-testsuite/blob/master/tests/03-spu_run/01-spu_run.c
> 
> ... might need some debugging here, I'll update if I find anything.

And it appears we're stuck in the POLL_WHILE_FALSE() loop in
wait_tag_complete() called from restore_lscsa().

Because spufs itself has been fairly static, I suspect some other change
has meant that MFC DMAs aren't working; so at this point, a bisect might
be the best way forward. Do you see the exact same behaviour on 4.9 (but
4.8 works?)

Cheers,


Jeremy
