MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16399.8399.251173.659871@cargo.ozlabs.ibm.com>
Date: Thu, 22 Jan 2004 12:01:03 +1100
From: Paul Mackerras <paulus@samba.org>
To: Etsushi Kato <ekato@ees.hokudai.ac.jp>
Cc: Hollis Blanchard <hollisb@us.ibm.com>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: local_irq_enable() problem...
In-Reply-To: <60A99FA3-4BF7-11D8-A780-00039394E428@ees.hokudai.ac.jp>
References: <10F0AFAD-4B61-11D8-8D03-000A95A0560C@us.ibm.com>
	<60A99FA3-4BF7-11D8-A780-00039394E428@ees.hokudai.ac.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Etsushi Kato writes:

> Is there any way to check whether exception handling code is working
> correctly?  Register usage in head.S and entry.S seems to be changed
> from 2.4, so perhaps I missed porting some part.

Yes - the main difference is that we now don't save all the registers
on the common interrupt/exception entries.  We only save the volatile
registers, since the C code saves and restores all the nonvolatile
registers.  We do this for external interrupt, decrementer and system
call, at least.  Other exception entries that are likely to result in
sending a signal to the current process save all the registers.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
