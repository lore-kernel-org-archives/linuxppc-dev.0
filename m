Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id 65805DDF45
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Apr 2007 00:58:53 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so157174ugf
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Apr 2007 07:58:51 -0700 (PDT)
Message-ID: <528646bc0704240758t4d230ab9ga025a3a49614ce98@mail.gmail.com>
Date: Tue, 24 Apr 2007 08:58:50 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Andrei Konovalov" <akonovalov@ru.mvista.com>,
	"Linux PPC" <linuxppc-embedded@ozlabs.org>
Subject: Re: ML403, root=/dev/xsa3 rw, bonnie++
In-Reply-To: <462E17BF.3080404@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <462E17BF.3080404@ru.mvista.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/24/07, Andrei Konovalov <akonovalov@ru.mvista.com> wrote:
> Hi Grant,
>
> I've discovered the IBM Microdrive fits perfectly into the ML403 CF slot :)
> So I've repeated the bonnie++ stress test on ML403 with the hard disk.
> The log is below.
> The test completed OK, but there was one message from the driver in the middle
> of the test:
> "[  776.712206] xsysace xsa: kicking stalled fsm; state=3 task=3 iter=7829 dc=0"

I added a kernel timer to the sysace driver to give the state machine
a nudge if there is no activity after a short amount of time; for
example, if an interrupt is missed.  It is a rare condition, but if it
happens, then the timer keeps the driver from hanging up completely.

I don't know how to avoid the condition.  It seems to be related to
the CFBSY and DATARDY status bits.  It seems that sometimes the sysace
raises a DATARDY irq, but the driver cannot do anything because CFBSY
is set.  Then, after clearing that condition and yielding for a bit a
subsequent DATARDY irq is lost and the state machine stalls.

Thanks for the testing, it's a big help.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
