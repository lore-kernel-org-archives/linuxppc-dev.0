Return-Path: <jroth@linux.vnet.ibm.com>
Message-ID: <4822B0C1.5060604@linux.vnet.ibm.com>
Date: Thu, 08 May 2008 09:50:25 +0200
From: Jochen Roth <jroth@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Carl Love <cel@us.ibm.com>
Subject: Re: [Cbe-oss-dev] [PATCH] Updated: Reworked Cell OProfile: SPU mutex
	lock fix
References: <1209587712.7531.42.camel@carll-linux-desktop>
	<4821DEB0.7050308@linux.vnet.ibm.com>
	<1210180166.7726.19.camel@carll-linux-desktop>
In-Reply-To: <1210180166.7726.19.camel@carll-linux-desktop>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: linuxppc-dev@ozlabs.org, oprofile-list <oprofile-list@lists.sf.net>,
	cbe-oss-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel <linux-kernel@vger.kernel.org>
Reply-To: jroth@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Carl Love wrote:

>>  > +void oprofile_add_value(unsigned long value, int cpu) {
>>  > +	struct oprofile_cpu_buffer * cpu_buf = &cpu_buffer[cpu];
>>
>> Shouldn't it be
>> 	struct oprofile_cpu_buffer *cpu_buf = &per_cpu(cpu_buffer, cpu);
> 
> No, I don't think so.  Take a look at the other functions in
> drivers/oprofile/cpu_buffer.c.  For example oprofile_add_trace().  You
> will see that the cpu_buffer is not accessed using the per_cpu
> construct.  Not sure why the compiler would complain about the
> oprofile_add_value() function but not one of the other functions like
> oprofile_add_trace().

Well, actually the other functions like oprofile_add_trace are using the 
&__get_cpu_var(cpu_buffer) construct.

> What was the compiler error that you saw?

Here they are:
/home/jroth/kernel/spufs/arch/powerpc/oprofile/../../../drivers/oprofile/cpu_buffer.c: 
In function ‘oprofile_add_value’:
/home/jroth/kernel/spufs/arch/powerpc/oprofile/../../../drivers/oprofile/cpu_buffer.c:234: 
error: ‘cpu_buffer’ undeclared (first use in this function)

cpu_buffer is defined by the DEFINE_PER_CPU_SHARED_ALIGNED macro:
DEFINE_PER_CPU_SHARED_ALIGNED(struct oprofile_cpu_buffer, cpu_buffer);

> I will try getting Jeremy's kernel and applying the patch there to see
> if it works.

You'll find his tree at 
git://git.kernel.org/pub/scm/linux/kernel/git/jk/spufs.git
