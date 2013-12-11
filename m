Return-Path: <benh@kernel.crashing.org>
Message-ID: <1386755340.15730.11.camel@pasglop>
Subject: Re: [PATCH] powerpc: set default kernel thread priority to medium-low
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 11 Dec 2013 20:49:00 +1100
In-Reply-To: <1386743357.27999.1.camel@concordia>
References: <1386661163-4478-1-git-send-email-felix@linux.vnet.ibm.com>
 <1386743357.27999.1.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-12-11 at 17:29 +1100, Michael Ellerman wrote:

> It would be nice if you could make an assertion about what the state of HMT
> handling should be once your patch is applied.
> 
> I think it's:
> 
>  * The kernel should use HMT_MEDIUM_LOW as it's "default" priority
>  * The kernel should use HMT_LOW as it's "low" priority
> 
> Which would imply:
> 
>  * The kernel should not use HMT_MEDIUM anywhere ..
>  * Nor should it use any of the other higher HMT modes.
> 
> Do you agree?
> 
> The reason I ask is I still see HMT_MEDIUM used in a few places, and it's not
> clear to me if that is correct.

HMT_MEDIUM used to be our default no ?

Also there's an open question... when doing things with interrupts off
(or worse, in real mode) such as some KVM hcalls etc... should we on the
contrary boost up to limit interrupt latency ?

Ben.
