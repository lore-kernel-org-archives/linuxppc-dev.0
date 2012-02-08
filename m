Return-Path: <joey@joescan.com>
Received: from exprod7og116.obsmtp.com (exprod7og116.obsmtp.com [64.18.2.219])
 by ozlabs.org (Postfix) with SMTP id 87CD4B6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2012 13:47:07 +1100 (EST)
Received: by mail-lpp01m010-f43.google.com with SMTP id p5so109505lag.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Feb 2012 18:47:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAL_WD7hkuhi4D2CPuoLyG2-7w8JmSQDnxiYbqKxzGNep5ONsrg@mail.gmail.com>
References: <CAL_WD7hYZoaB87vZzj4Fk9nsHYSoe+qWq87g72ERLAkMur5vYg@mail.gmail.com>
 <CAL_WD7iJceKMOX9dWDM-SuiO5a_M-3Kp4FnZqS+AuEKvphq_-w@mail.gmail.com>
 <CAL_WD7hkuhi4D2CPuoLyG2-7w8JmSQDnxiYbqKxzGNep5ONsrg@mail.gmail.com>
Date: Tue, 7 Feb 2012 18:47:04 -0800
Message-ID: <CAL_WD7jdk78ba9HJ0rYxc1fvVS-PBY4zK6MWhF3H2B_dzFkv_g@mail.gmail.com>
Subject: Re: MPC5200B FEC TX packets getting stuck
From: Joey Nelson <joey@joescan.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I've revisited my testing, and found I was wrong about the packets
getting stuck in the FEC queue.  The packets are getting stuck in the
bestcomm.

I generate a timestamp for each skb's ip_hdr->id at the beginning of
mpc52xx_fec_start_xmit, and for each skb retrieved from the bestcomm.

Typically the packets make it through bestcomm in under 200us.  But
sometimes a single packet will sit in bestcomm until the next packet
added.  In the case of a delayed ACK this can be around 400ms.

When I look at the state of the registers when this condition is
detected (before adding the next bd):

tx_dmatsk->flags = 1
tcr[1] = 0x20c1

Both of these values seem to indicate the the TX task is disabled.
I'm pretty sure that nothing in the kernel is disabling the task, so
it must be an automatic behavior.  I notice that
bcom_submit_next_buffer() checks the task->flags and if the LSB is set
it enables the task.  So I'm guessing that is what gets things moving
again when the freeze happens.

My best guess is this is a race condition between the driver and the
dma controller.  Is there any risk to just calling bcom_enable(tsk).
Maybe after a short sleep.


Joey Nelson
