Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id 3617E67D1B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Dec 2006 09:09:04 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1827669ugf
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Dec 2006 14:09:02 -0800 (PST)
Message-ID: <528646bc0612121409r59eac2d5n7c9072d569dfebd2@mail.gmail.com>
Date: Tue, 12 Dec 2006 15:09:01 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "jimmy liu" <jimmyzhmliu@yahoo.com>
Subject: Re: Floating Point Operation in Kernel
In-Reply-To: <426172.37473.qm@web53101.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <426172.37473.qm@web53101.mail.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 12/12/06, jimmy liu <jimmyzhmliu@yahoo.com> wrote:
> I am writing a module which need be integrated to the
> linux kernel with floating point operations for
> mpc82xx. The kernel does not provide support for
> floating point operations. Does anybody have good idea
> to implement it or make it to work around?

The official answer is: "Don't do that."  :)

Here's the more generous reply:  The kernel explicitly does not
support floating point in the kernel.  Save/restore on floating point
registers is expensive.  In fact, IIRC, floating point registers for
user space use 'lazy save/restore'; ie. the registers are not saved on
every context switch; they are only saved if another user space
process tries to perform FP operations.

To support FP access in kernel space means you must fit your code into
the already complex FP save/restore state machine; or you need to
disable all interrupts and perform your own FP register save/restore
within the context of your driver.  And it's a pretty safe bet that
you'll have trouble getting the driver into mainline.

Why do you need kernel space FP?

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
