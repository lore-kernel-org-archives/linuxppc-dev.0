Return-Path: <jonsmirl@gmail.com>
MIME-Version: 1.0
In-Reply-To: <9e4733910904171758m1e09087fld63b28db1d0352c2@mail.gmail.com>
References: <9e4733910904171758m1e09087fld63b28db1d0352c2@mail.gmail.com>
Date: Fri, 17 Apr 2009 21:36:30 -0400
Message-ID: <9e4733910904171836g1a1507d8geaf102a1cc5455a9@mail.gmail.com>
Subject: Re: mpc5200 and dma_ops
From: Jon Smirl <jonsmirl@gmail.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 17, 2009 at 8:58 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> Inside the ASoC code there a dma_alloc_coherent() call. This call is
> failing because dma_ops is null.
> --kernel BUG at /home/jonsmirl/fs/arch/powerpc/include/asm/dma-mapping.h:237!
> The device is soc-audio which is a platform_device.
>
> How do I get dma_ops filled in for a mpc5200 platform device?

That was a wild goose chase. If the device pointer is null it will
trigger this bug_on() which has nothing to do with the real problem.

-- 
Jon Smirl
jonsmirl@gmail.com
