In-Reply-To: <411369F9.5060506@rossvideo.com>
References: <20040806081151.B77FCC109F@atlas.denx.de> <411369F9.5060506@rossvideo.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <884A8F94-E7A5-11D8-9B14-003065F9B7DC@embeddededge.com>
Cc: PPC_LINUX <linuxppc-embedded@lists.linuxppc.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: Init hangs
Date: Fri, 6 Aug 2004 08:38:34 -0400
To: Ralph Siemsen <rsiemsen@rossvideo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Aug 6, 2004, at 7:22 AM, Ralph Siemsen wrote:

> This could also be a floating point issue.

I doubt it.  The processor in question is an 8270, which
has an FPU.

>   Most code compiled against
> libc will try to "reset" the floating point state upon startup.  This
> will cause a fault if you do not have a kernel floating point emulator
> of some sort loaded to handle it.

On the MPC8xx, which does not have a floating point unit,
there is still sufficient support in the kernel to trap and emulate
FPU reset and context save/restore for this purpose.  You only
need the CONFIG_MATH_EMULATION is you intend to
really do floating point arithmetic.

>  (Even though init doesn't use any
> floating point itself).  So as a quick test try building your kernel
> with CONFIG_MATH_EMULATION=y

This should not be used with any processor that has hardware
floating point.  In the rare cases where you may actually be
utilizing IEEE trap conditions, these functions could get in the
way and produce erroneous results.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
