Return-Path: <mpe@ellerman.id.au>
Message-ID: <1386743357.27999.1.camel@concordia>
Subject: Re: [PATCH] powerpc: set default kernel thread priority to medium-low
From: Michael Ellerman <mpe@ellerman.id.au>
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>
Date: Wed, 11 Dec 2013 17:29:17 +1100
In-Reply-To: <1386661163-4478-1-git-send-email-felix@linux.vnet.ibm.com>
References: <1386661163-4478-1-git-send-email-felix@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-12-10 at 08:39 +0100, Philippe Bergheaud wrote:
> All the important PThread locking occurs in GLIBC libpthread.so
> 
> For scaling to large core counts we need to stay out of the kernel and scheduler as much as possible which implies increasing the spin time in user mode. For POWER implementations with SMT this implies that user mode needs to manage SMT priority for spinning and active (in the critical region) threads.
> 
> Libpthread must be able to raise and lower the the SMT priority versus the default to be effective.
> 
> This lowers the default kernel thread priority from medium to medium-low.

Hi Philippe,

It would be nice if you could make an assertion about what the state of HMT
handling should be once your patch is applied.

I think it's:

 * The kernel should use HMT_MEDIUM_LOW as it's "default" priority
 * The kernel should use HMT_LOW as it's "low" priority

Which would imply:

 * The kernel should not use HMT_MEDIUM anywhere ..
 * Nor should it use any of the other higher HMT modes.

Do you agree?

The reason I ask is I still see HMT_MEDIUM used in a few places, and it's not
clear to me if that is correct.

cheers
