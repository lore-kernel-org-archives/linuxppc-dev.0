Return-Path: <rdreier@cisco.com>
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	by ozlabs.org (Postfix) with ESMTP id 366F167AA0
	for <linuxppc-dev@ozlabs.org>; Sat, 27 May 2006 06:06:49 +1000 (EST)
To: Heiko J Schick <schihei@de.ibm.com>
Subject: Re: [openib-general] [PATCH 06/16] ehca: interrupt handling routines
References: <4468BD63.6070509@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 26 May 2006 13:06:44 -0700
In-Reply-To: <4468BD63.6070509@de.ibm.com> (Heiko J. Schick's message of "Mon,
	15 May 2006 19:41:55 +0200")
Message-ID: <ada3bewh7or.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > +	for_each_online_cpu(cpu) {
 > +		task = create_comp_task(pool, cpu);
 > +		if (task) {
 > +			kthread_bind(task, cpu);
 > +			wake_up_process(task);
 > +		}
 > +	}

How does this creation of a thread pool work with respect to CPU
hotplug?  What happens if a CPU goes away?  How about if only one CPU
is running when the driver is loaded, and then 15 more are hot-added?

 > +	for (i = 0; i < NR_CPUS; i++) {
 > +		if (cpu_online(i))
 > +			destroy_comp_task(pool, i);
 > +	}

And it seems in the destroy function, you will possibly leak threads
or try to kill a non-existent thread if the set of online CPUs has
changed since the driver started...

 - R.
