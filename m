Return-Path: <dwilson@dslextreme.com>
Received: from mail5.dslextreme.com (mail5.dslextreme.com [66.51.199.81])
	by ozlabs.org (Postfix) with SMTP id D70DE679F0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Mar 2006 01:34:54 +1100 (EST)
Message-ID: <200603220628100675.0019366F@smtp.dslextreme.com>
Date: Wed, 22 Mar 2006 06:28:10 -0800
From: "Dan Wilson" <dwilson@dslextreme.com>
To: linuxppc-embedded@ozlabs.org
Subject: software-triggered reset of MPC8541
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

My apologies for asking a question in this mailing list that is somewhat=
 off-topic, but this is the best list I know of for such a question:

We are trying to implement a software function to reset an 8541.  The ELDK=
 4.0 kernel includes an abort() function that does this by setting the=
 appropriate bits in DBCR0.  In our tests, this unfailingly reboots the=
 unit.  A colleague has put an identical function into a non-linux-based=
 application on which he is working, and finds that most of the time the=
 unit reboots as expected, but sometimes it just hangs.

My question is: does the linux kernel do anything special to prepare the=
 processor environment for this reboot prior to calling abort()?  The only=
 thing I could find was a call to local_irq_disable(), which does:
static inline void local_irq_disable(void)
{
#ifdef CONFIG_BOOKE
        __asm__ __volatile__("wrteei 0": : :"memory");
#else
        unsigned long msr;
        __asm__ __volatile__("": : :"memory");
        msr =3D mfmsr();
        SET_MSR_EE(msr & ~MSR_EE);
#endif
}

As the 8541 is an E500 core, I believe it is the #ifdef CONFIG_BOOKE code=
 that is being executed.  The wrteei 0 instruction is clear enough.  What=
 does the rest of that line do (i.e., the repeated colons and the memory=
 command)?  I haven't been able to find a memory command in the ppc=
 instruction set documents that I have?

Thanks in advance for any help anyone can give to help us understand this=
 code sequence better!

Best regards,

Dan.
