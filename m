Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tZtmj0gWJzDw2w
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Dec 2016 00:46:12 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB9DhwZc108034
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Dec 2016 08:46:10 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 277wcj1qbs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Dec 2016 08:46:10 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Fri, 9 Dec 2016 06:46:09 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 928E91FF0021
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2016 06:45:46 -0700 (MST)
Date: Fri, 9 Dec 2016 05:46:16 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Sachin Sant <sachinp@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: 4.9.0-rc8 - rcutorture test failure
Reply-To: paulmck@linux.vnet.ibm.com
References: <53527A2F-3F17-460F-87DE-67034A5325B8@linux.vnet.ibm.com>
 <20161208113747.GC3924@linux.vnet.ibm.com>
 <CDF45845-385E-454E-9C25-004F76C4E41E@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CDF45845-385E-454E-9C25-004F76C4E41E@linux.vnet.ibm.com>
Message-Id: <20161209134616.GW3924@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 09, 2016 at 04:27:42PM +0530, Sachin Sant wrote:
> > But I am not seeing this as a failure.  The last status print from the
> > log you attached is as follows:
> > 
> > 07:58:25 [ 2778.876118] rcu-torture: rtc:           (null) ver: 24968 tfle: 0 rta: 24968 rtaf: 0 rtf: 24959 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 10218404 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 cbflood: 22703
> > 07:58:25 [ 2778.876251] rcu-torture: Reader Pipe:  161849976604 399197 0 0 0 0 0 0 0 0 0
> > 07:58:25 [ 2778.876438] rcu-torture: Reader Batch:  145090807711 16759538163 0 0 0 0 0 0 0 0 0
> > 07:58:25 [ 2778.876625] rcu-torture: Free-Block Circulation:  24967 24967 24966 24965 24964 24963 24962 24961 24960 24959 0
> > 07:58:25 [ 2778.876829] rcu-torture:--- End of test: SUCCESS: nreaders=79 nfakewriters=4 stat_interval=60 verbose=1 test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0 test_boost_interval=7 test_boost_duration=4 shutdown_secs=0 stall_cpu=0 stall_cpu_holdoff=10 n_barrier_cbs=0 onoff_interval=0 onoff_holdoff=0
> > 
> > The "SUCCESS" indicates that rcutorture thought that it succeeded.
> > Also, in the "Reader Pipe" and "Reader Batch" lines, only the first two
> > numbers in the series at the end of each line are non-zero, which also
> > indicates a non-broken RCU.
> > 
> > So could you please let me know what your scripting didn't like about
> > this log?
> > 
> 
> The test case has following piece of code which prints the failure
> message during result analysis.
> 
> Checks for known bugs
> """
> utils.system('dmesg -c  > /dev/null')
> pipe1 = [r for r in self.results if "!!! Reader Pipe:" in r]
> if len(pipe1) != 0:
>      raise error.TestError('\nBUG: grace-period failure !’)
>      sys.exit(0)
> 
> pipe2 = [r for r in self.results if "Reader Pipe" in r]
> for p in pipe2:
>       nmiss = p.split(" ")[7]
>       if int(nmiss):
>           raise error.TestError('\nBUG: rcutorture tests failed !')
>           sys.exit(0)
> 
> I will double check on this.

I suggest using this script in the Linux kernel source as a guide:

	tools/testing/selftests/rcutorture/bin/parse-console.sh

							Thanx, Paul
