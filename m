From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15625.4799.671581.186354@argo.ozlabs.ibm.com>
Date: Fri, 14 Jun 2002 07:46:39 +1000 (EST)
To: Steffen Rumler <Steffen.Rumler@icn.siemens.de>
Cc: Neil Horman <nhorman@lvl7.com>,
	linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Accessing the user stack inside system call service routine
In-Reply-To: <3D08AA25.9AF41113@icn.siemens.de>
References: <3D084D1F.95AFFCBB@icn.siemens.de>
	<3D087D95.5070206@lvl7.com>
	<3D08AA25.9AF41113@icn.siemens.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steffen Rumler writes:

> The copy_from_user() works fine. The printk() message does not
> appear.

The copy_from_user call looks correct to me.

> Later, when I inspect 'current->user_stack_xxx' (temporary
> added to struct_task) for all processes with 'current->in_suspend'
> set, all seems to be zero. I do this check within a kernel
> module, I can load when the threads are hanging.

That is indeed very strange.  The first word should be non-zero at the
very least.  Is it possible that your program has in fact trashed its
stack?  Another thing to try would be to check the contents of
current->user_stack_xxx immediately after you copy it to see whether
it is all zero at that point.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
