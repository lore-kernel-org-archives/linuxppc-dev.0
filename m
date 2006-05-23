Return-Path: <linas@austin.ibm.com>
Date: Tue, 23 May 2006 11:48:41 -0500
To: Anton Blanchard <anton@samba.org>
Subject: Re: Maple: killing a  process that causes a machine check exception
Message-ID: <20060523164841.GA25867@austin.ibm.com>
References: <44732357.4000506@yahoo.fr> <20060523151541.GB10468@krispykreme>
	<447333BF.6060306@yahoo.fr> <20060523162348.GC5938@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060523162348.GC5938@krispykreme>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc64-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 24, 2006 at 02:23:48AM +1000, Anton Blanchard wrote:
> jfaslist <jfaslist@yahoo.fr> wrote:
> > What do you mean by synchronous? Do you mean that the current process 
> > may no be not the one that caused the ME?
> 
> Yeah, a device doing DMA might cause a machine check independent to your
> current task. In that case we really need to take the machine down.
> 
> > In my case I _need_ the process to be killed, as it is making a VME bus 
> > error. / PCI target-abort.
> 
> Sounds like you need a Maple specific machine check handler. My point is
> we cant merge a fix like that because it affects every powerpc arch out
> there, all with different machine check handling requirements.

Here's an utterly crazy idea that might take a lot of work to implement,
but might help with the problem. *If* it can be determined which pci device 
caused the error, then it might be possible to reset the PCI device and
restart the device driver. 

There is an existing infrastructure for "PCI Error Recovery" (known as
EEH on the pSeries) for detecting and clearing PCI bus errors.  On the
pSeries, it depends on a combination of custom hardware PCI bridges and 
firmware to isolate the failing device; but maybe on other systems, one 
might be able to do "almost" as well.

(See kernel source, Documentation/pci-error-recovery.txt)

--linas
