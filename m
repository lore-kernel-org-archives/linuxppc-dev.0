Return-Path: <alan@akb.net>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.227])
	by ozlabs.org (Postfix) with ESMTP id 235ABDDEBC
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 02:47:44 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so477404nzh
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 09:47:43 -0700 (PDT)
Message-ID: <bfa0697f0710220947t657b209ek6f6a011cd1e6e5cf@mail.gmail.com>
Date: Mon, 22 Oct 2007 10:47:41 -0600
From: "Alan Bennett" <embedded@akb.net>
Sender: alan@akb.net
To: linuxppc-dev@ozlabs.org
Subject: request_irq fails to get interrupt 12
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Freescale experts.  Why on earth can't I request the IRQ for Timer1?

static int __init
dvr_ph_init(void)
{
	u32	rv;
	int k;
	//rv = driver_register(&dvr_ph_driver);
	for (k=0;k<64;k++) {
		rv = request_irq(k,dvrph_isr , 0, "dvr_ph", NULL);
		if (rv!=-38) printkplus("request_irq for %d returns %d", k,rv);
	}
	return rv;
}

Results in:
dvr_ph_init    145 - enter the routine
dvr_ph_init    155 -
dvr_ph_init    161 - request_irq for 16 returns -16  (vector 16 = TMCNT)
dvr_ph_init    161 - request_irq for 32 returns 0  (vector 32 = FCC1)
dvr_ph_init    161 - request_irq for 33 returns -16  (vector 33 = FCC2)
dvr_ph_init    161 - request_irq for 40 returns 0  (vector 40 = SCC1)
dvr_ph_init    161 - request_irq for 43 returns 0  (vector 43 = SCC4)
