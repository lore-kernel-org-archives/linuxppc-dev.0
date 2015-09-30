Return-Path: <dja@axtens.net>
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 441E11A00C5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 09:50:09 +1000 (AEST)
Received: by padhy16 with SMTP id hy16so54606916pad.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 16:50:06 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
Cc: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Tomas Henzl <thenzl@redhat.com>, David Laight <David.Laight@ACULAB.COM>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 17/32] cxlflash: Remove dual port online dependency
In-Reply-To: <FD47E8E4-D768-401E-8A4C-31A3E37E359B@linux.vnet.ibm.com>
References: <1443222593-8828-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1443223018-9577-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <87a8s6und0.fsf@gamma.ozlabs.ibm.com>
 <FD47E8E4-D768-401E-8A4C-31A3E37E359B@linux.vnet.ibm.com>
Date: Thu, 01 Oct 2015 09:50:00 +1000
Message-ID: <87si5vsc0n.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


(resending to the list this time, apologies!)

>> I'm not sure I fully understand the flow of this function, but it looks
>> like you set rc=0 regardless of how things actually go: is this ever
>> going to print a return value other than zero?
>
> Correct, this function behaves more like a void for the time being. The
> overall goal of this is to allow a card to configure even when the link is
> down. At some later point when the link is transitioned to 'up', a link state
> change interrupt will trigger the port configuration. I left this with a return
> code for right now in case we need to alter the behavior again (based
> upon testing) and actually return a value other than 0.

OK. That makes more sense - it wasn't clear to me how it could be
correct to proceed if the links were down but now I understand how that
works. I think that explanation should go in the commit message.

>>> 	if (!wait_port_online(fc_regs, FC_PORT_STATUS_RETRY_INTERVAL_US,
>>> 			      FC_PORT_STATUS_RETRY_CNT)) {
>>> 		pr_debug("%s: wait on port %d to go online timed out\n",
>>> 			 __func__, port);

As an aside, should this be a bit noisier? It seems like something
a user would probably want to know - especially in the case where
something has actually gone wrong so there's no link state change
interrupt forthcoming regardless of how long you wait.

Regards,
Daniel
