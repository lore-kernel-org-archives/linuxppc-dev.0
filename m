Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E41B72C0096
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 10:16:01 +1000 (EST)
Message-ID: <1369181713.6387.79.camel@pasglop>
Subject: Re: [PATCH 0/3] Enable multiple MSI feature in pSeries
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Gordeev <agordeev@redhat.com>
Date: Wed, 22 May 2013 10:15:13 +1000
In-Reply-To: <20130521144548.GB21632@dhcp-26-207.brq.redhat.com>
References: <1358235536-32741-1-git-send-email-qiudayu@linux.vnet.ibm.com>
 <20130521144548.GB21632@dhcp-26-207.brq.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, tglx@linutronix.de,
 Mike Qiu <qiudayu@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-05-21 at 16:45 +0200, Alexander Gordeev wrote:
> On Tue, Jan 15, 2013 at 03:38:53PM +0800, Mike Qiu wrote:
> > The test results is shown by 'cat /proc/interrups':
> >           CPU0       CPU1       CPU2       CPU3       
> > 16:     240458     261601     226310     200425      XICS Level     IPI
> > 17:          0          0          0          0      XICS Level     RAS_EPOW
> > 18:         10          0          3          2      XICS Level     hvc_console
> > 19:     122182      28481      28527      28864      XICS Level     ibmvscsi
> > 20:        506    7388226        108        118      XICS Level     eth0
> > 21:          6          5          5          5      XICS Level     host1-0
> > 22:        817        814        816        813      XICS Level     host1-1
> 
> Hi Mike,
> 
> I am curious if pSeries firmware allows changing affinity masks independently
> for multiple MSIs? I.e. in your example, would it be possible to assign IRQ21
> and IRQ22 to different CPUs?

Yes. Each interrupt has its own affinity, whether it's an MSI or not,
the affinity is not driven by the address.

Cheers,
Ben.

> Thanks!
> 
> > LOC:     398077     316725     231882     203049   Local timer interrupts
> > SPU:       1659        919        961        903   Spurious interrupts
> > CNT:          0          0          0          0   Performance
> > monitoring interrupts
> > MCE:          0          0          0          0   Machine check exceptions
> 
