Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 64C8D2C032B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Mar 2014 13:59:07 +1100 (EST)
Message-ID: <1394161051.26321.71.camel@pasglop>
Subject: Re: [PATCH v2 14/52] powerpc, sysfs: Fix CPU hotplug callback
 registration
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Date: Fri, 07 Mar 2014 13:57:31 +1100
In-Reply-To: <20140214075215.22701.23653.stgit@srivatsabhat.in.ibm.com>
References: <20140214074750.22701.47330.stgit@srivatsabhat.in.ibm.com>
 <20140214075215.22701.23653.stgit@srivatsabhat.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, ego@linux.vnet.ibm.com, walken@google.com,
 linux@arm.linux.org.uk, akpm@linux-foundation.org,
 Wang Dongsheng <dongsheng.wang@freescale.com>, peterz@infradead.org,
 rusty@rustcorp.com.au, rjw@rjwysocki.net, oleg@redhat.com,
 linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, paulus@samba.org,
 tj@kernel.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-02-14 at 13:22 +0530, Srivatsa S. Bhat wrote:
> Subsystems that want to register CPU hotplug callbacks, as well as perform
> initialization for the CPUs that are already online, often do it as shown
> below:
> 
> 	get_online_cpus();
> 
> 	for_each_online_cpu(cpu)
> 		init_cpu(cpu);
> 
> 	register_cpu_notifier(&foobar_cpu_notifier);
> 
> 	put_online_cpus();

This patch breaks a good half of my test configs with:

/home/benh/linux-powerpc-test/arch/powerpc/kernel/sysfs.c: In function 'topology_init':
/home/benh/linux-powerpc-test/arch/powerpc/kernel/sysfs.c:979:2: error: implicit declaration of function 'cpu_notifier_register_begin' [-Werror=implicit-function-declaration]
/home/benh/linux-powerpc-test/arch/powerpc/kernel/sysfs.c:1004:2: error: implicit declaration of function '__register_cpu_notifier' [-Werror=implicit-function-declaration]
/home/benh/linux-powerpc-test/arch/powerpc/kernel/sysfs.c:1006:2: error: implicit declaration of function 'cpu_notifier_register_done' [-Werror=implicit-function-declaration]
cc1: all warnings being treated as errors
make[2]: *** [arch/powerpc/kernel/sysfs.o] Error 1
make[2]: *** Waiting for unfinished jobs....
