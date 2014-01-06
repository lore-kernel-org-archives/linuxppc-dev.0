Return-Path: <scottwood@freescale.com>
Message-ID: <1389045939.11795.104.camel@snotra.buserror.net>
Subject: Re: [question] Can the execution of the atomtic operation
 instruction pair lwarx/stwcx be interrrupted by local HW interruptions?
From: Scott Wood <scottwood@freescale.com>
To: wyang <w90p710@gmail.com>
Date: Mon, 6 Jan 2014 16:05:39 -0600
In-Reply-To: <52CA3ED7.2020407@gmail.com>
References: <CABiPGEfmEFovARBy0rwjbDpBnVeRrmvQrxgnH+32z0RLUX3Nkw@mail.gmail.com>
 <52C0D251.2000400@gmail.com>
 <CABiPGEcHxgmuLMcMN1ByutJC22RJPHSZf3n5gF9BgenbfQTJvA@mail.gmail.com>
 <52CA3ED7.2020407@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Linuxppc-dev@lists.ozlabs.org, Gavin Hu <gavin.hu.2010@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-01-06 at 13:27 +0800, wyang wrote:
> 
> On 01/06/2014 11:41 AM, Gavin Hu wrote:
> 
> > Thanks your response.  :) 
> > But that means that these optimitive operations like atomic_add()
> > aren't optimitive actully in PPC architecture, right? Becuase they
> > can be interrupted by loacl HW interrupts. Theoretically, the ISR
> > also can access the atomic gloable variable.
> > 
> 
> Nope, my understand is that if you wanna sync kernel primitive code
> with ISR, you have responsibility to disable local interrupts.
> atomic_add does not guarantee to handle such case.

atomic_add() and other atomics do handle that case.  Interrupts are not
disabled, but there's a stwcx. in the interrupt return code to make sure
the reservation gets cleared.

-Scott
