Return-Path: <hpa@zytor.com>
Received: from terminus.zytor.com (terminus.zytor.com [192.83.249.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3318ADDF58
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 04:44:12 +1100 (EST)
Message-ID: <45AD02FF.605@zytor.com>
Date: Tue, 16 Jan 2007 08:53:19 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 0/59] Cleanup sysctl
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	linux-parport@lists.infradead.org, heiko.carstens@de.ibm.com,
	ak@suse.de, linuxppc-dev@ozlabs.org, paulus@samba.org,
	aharkes@cs.cmu.edu, schwidefsky@de.ibm.com, tim@cyberelk.net,
	rtc-linux@googlegroups.com, linux-scsi@vger.kernel.org,
	kurt.hackel@oracle.com, coda@cs.cmu.edu, vojtech@suse.cz,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	James.Bottomley@SteelEye.com, clemens@ladisch.de,
	xfs@oss.sgi.com, xfs-masters@oss.sgi.com, andrea@suse.de,
	openipmi-developer@lists.sourceforge.net,
	linux-390@vm.marist.edu, codalist@TELEMANN.coda.cs.cmu.edu,
	a.zummo@towertech.it, tony.luck@intel.com,
	linux-ntfs-dev@lists.sourceforge.net, netdev@vger.kernel.org,
	aia21@cantab.net, linux-kernel@vger.kernel.org,
	ralf@linux-mips.org, lethal@linux-sh.org,
	Linux Containers <containers@lists.osdl.org>,
	linux390@de.ibm.com, philb@gnu.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Eric W. Biederman wrote:
> 
> - Removal of sys_sysctl support where people had used conflicting sysctl
>   numbers. Trying to break glibc or other applications by changing the
>   ABI is not cool.  9 instances of this in the kernel seems a little
>   extreme.
> 

It would be highly advantageous if we could have a file that acts as a 
central registry of architectural sysctl numbers *and have the numbers 
in the kernel derived from there*.  As I've said before, I don't really 
think sys_sysctl is any worse than ad hoc system calls (sys_mips and the 
like), but the real problem is that there are architectural and 
non-archtectural numbers, and they're mixed in all over the place.

I think it would be fair to say that if they're not in <linux/sysctl.h> 
they're not architectural, but that doesn't resolve the counterpositive 
(are there sysctls in <linux/sysctl.h> which aren't architectural?  From 
the looks of it, I would say yes.)  Non-architectural sysctl numbers 
should not be exported to userspace, and should eventually be rejected 
by sys_sysctl.

	-hpa
