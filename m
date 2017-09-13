Return-Path: <npiggin@gmail.com>
Date: Wed, 13 Sep 2017 23:27:16 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, skiboot@lists.ozlabs.org, Alistair Popple
 <alistair@popple.id.au>
Subject: Re: [RFC PATCH 1/2] core: implement OPAL_SIGNAL_SYSTEM_RESET with
 POWER9 scoms
Message-ID: <20170913232716.138ca093@roar.ozlabs.ibm.com>
In-Reply-To: <1505258314.12628.151.camel@kernel.crashing.org>
References: <20170912160553.13422-1-npiggin@gmail.com>
 <20170912160553.13422-2-npiggin@gmail.com>
 <1505258314.12628.151.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 13 Sep 2017 09:18:34 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Wed, 2017-09-13 at 02:05 +1000, Nicholas Piggin wrote:
> > This implements a way to raise system reset interrupts on other
> > cores. This has not yet been tested on DD2 or with deeper sleep
> > states.  
> 
> Reminds me, we need to workaround a bug with XSCOMs on P9
> 
> PSCOMs to core in the range 20010A80-20010Ab8 (list below) can fail
> occasionally with an error of 4 (PCB_ADDRESS_ERROR). We need to
> (silently) retry up to 32 times.

[snip]

So, just put a loop into xscom_read and xscom_write for those
addresses for P9 chips?

Thanks,
Nick
