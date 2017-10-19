Return-Path: <dan.carpenter@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHrq44PPfzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 01:27:12 +1100 (AEDT)
Date: Thu, 19 Oct 2017 17:26:26 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>,
 linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Nayna Jain <nayna@linux.vnet.ibm.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Corentin Labbe <clabbe.montjoie@gmail.com>,
 Kenneth Goldman <kgold@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>,
 Peter =?iso-8859-1?Q?H=FCwe?= <PeterHuewe@gmx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 4/4] char/tpm: Less checks in tpm_ibmvtpm_probe() after
 error detection
Message-ID: <20171019142626.gwckkdbz7hsigakx@mwanda>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <09a2c3a1-1b10-507d-a866-258b570f6da1@users.sourceforge.net>
 <20171019135632.4af42743@kitsune.suse.cz>
 <9327cc83-448e-8404-af00-73f6409e269e@users.sourceforge.net>
 <20171019144655.7d06111c@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171019144655.7d06111c@kitsune.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

tpm_ibmvtpm_probe() is an example of poor names.  It has the generic
ones like "cleanup" which don't say *what* is cleaned and the come-from
ones like "init_irq_cleanup" which don't say anything useful at all:

   647          rc = request_irq(vio_dev->irq, ibmvtpm_interrupt, 0,
   648                           tpm_ibmvtpm_driver_name, ibmvtpm);
   649          if (rc) {
   650                  dev_err(dev, "Error %d register irq 0x%x\n", rc, vio_dev->irq);
   651                  goto init_irq_cleanup;
   652          }
   653  
   654          rc = vio_enable_interrupts(vio_dev);
   655          if (rc) {
   656                  dev_err(dev, "Error %d enabling interrupts\n", rc);
   657                  goto init_irq_cleanup;
   658          }

Sadly, we never do call free_irq().

> It can do it automatically, in most cases better, and automatically
> adapt it to code changes.

I've heard this before that if you only have one label that does
everything then it's "automatic" and "future proof".  It's not true.
The best error handling is methodical error handling:

1) In the reverse order from how things were allocated
2) That mirrors the allocations exactly
3) That frees one thing at a time
4) With a proper, useful, readable label name which says what the goto
   does
5) That doesn't free anything which hasn't been allocated

regards,
dan carpenter
