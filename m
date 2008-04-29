Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8FC83DDF47
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 18:56:44 +1000 (EST)
Message-Id: <30110DA2-3887-4679-9073-CC69A267E9DC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: overloading existing PTRACE_GET_DEBUGREG/PTRACE_SET_DEBUGREG commands
Date: Tue, 29 Apr 2008 03:56:31 -0500
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Anton Blanchard <anton@samba.org>, Roland McGrath <roland@redhat.com>,
	Paralkar Anmol <Anmol@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It looks like when Anton added the PTRACE_GET_DEBUGREG/ 
PTRACE_SET_DEBUGREG he envisioned future chips having more than one  
IABR/DABR.

I'm wondering what the feeling is about using the commands for  
handling some of the sub-arch variants we have:

e300 (603 style machine) - adds IABR2, DABR2, IBCR (control) and DBCR  
(control).  We can use IABR1/2 (and DABR1/2) either as unique  
addresses or for various ranges (inclusive or exclusive)

Book-e class machines can have the following registers: DBCR[0-2],  
IAC1-4, DAC1-2, DVC1-2, DBSR.  IACs are roughly equivalent to IABRs,  
DACs are roughly equivalent to DABRs.  Booke has similar ability to  
the e300 to do inclusive, exclusive ranges as well as some other  
features.

My question is how to handle providing access to the debug resources  
we have on these other machine types.  Should we just use GET_DEBUGREG/ 
SET_DEBUGREG and specify what the buffers look like for these specific  
machine types?  Is it ok to overload the commands this way?  How does  
this play with utrace?

Also, what functionality can GDB take advantage of today?  Does it  
comprehend the idea of breakpoints or watchpoints that cover a range?

- k
