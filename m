Return-Path: <sachinp@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tZq2f0NMKzDw7l
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2016 21:58:01 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB9AoPSU144352
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Dec 2016 05:57:59 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0b-001b2d01.pphosted.com with ESMTP id 277rtj76rq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Dec 2016 05:57:58 -0500
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sachinp@linux.vnet.ibm.com>;
 Fri, 9 Dec 2016 16:27:55 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id EBA2BE005E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2016 16:28:23 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB9AvpK642074306
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Dec 2016 16:27:51 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB9AvoYl016726
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Dec 2016 16:27:50 +0530
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Subject: Re: 4.9.0-rc8 - rcutorture test failure
From: Sachin Sant <sachinp@linux.vnet.ibm.com>
In-Reply-To: <20161208113747.GC3924@linux.vnet.ibm.com>
Date: Fri, 9 Dec 2016 16:27:42 +0530
Cc: linuxppc-dev@lists.ozlabs.org
References: <53527A2F-3F17-460F-87DE-67034A5325B8@linux.vnet.ibm.com>
 <20161208113747.GC3924@linux.vnet.ibm.com>
To: paulmck@linux.vnet.ibm.com
Message-Id: <CDF45845-385E-454E-9C25-004F76C4E41E@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> But I am not seeing this as a failure.  The last status print from the
> log you attached is as follows:
>=20
> 07:58:25 [ 2778.876118] rcu-torture: rtc:           (null) ver: 24968 =
tfle: 0 rta: 24968 rtaf: 0 rtf: 24959 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 =
rtbf: 0 rtb: 0 nt: 10218404 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=3D250) =
barrier: 0/0:0 cbflood: 22703
> 07:58:25 [ 2778.876251] rcu-torture: Reader Pipe:  161849976604 399197 =
0 0 0 0 0 0 0 0 0
> 07:58:25 [ 2778.876438] rcu-torture: Reader Batch:  145090807711 =
16759538163 0 0 0 0 0 0 0 0 0
> 07:58:25 [ 2778.876625] rcu-torture: Free-Block Circulation:  24967 =
24967 24966 24965 24964 24963 24962 24961 24960 24959 0
> 07:58:25 [ 2778.876829] rcu-torture:--- End of test: SUCCESS: =
nreaders=3D79 nfakewriters=3D4 stat_interval=3D60 verbose=3D1 =
test_no_idle_hz=3D1 shuffle_interval=3D3 stutter=3D5 irqreader=3D1 =
fqs_duration=3D0 fqs_holdoff=3D0 fqs_stutter=3D3 test_boost=3D1/0 =
test_boost_interval=3D7 test_boost_duration=3D4 shutdown_secs=3D0 =
stall_cpu=3D0 stall_cpu_holdoff=3D10 n_barrier_cbs=3D0 onoff_interval=3D0 =
onoff_holdoff=3D0
>=20
> The "SUCCESS" indicates that rcutorture thought that it succeeded.
> Also, in the "Reader Pipe" and "Reader Batch" lines, only the first =
two
> numbers in the series at the end of each line are non-zero, which also
> indicates a non-broken RCU.
>=20
> So could you please let me know what your scripting didn't like about
> this log?
>=20

The test case has following piece of code which prints the failure
message during result analysis.

Checks for known bugs
"""
utils.system('dmesg -c  > /dev/null')
pipe1 =3D [r for r in self.results if "!!! Reader Pipe:" in r]
if len(pipe1) !=3D 0:
     raise error.TestError('\nBUG: grace-period failure !=E2=80=99)
     sys.exit(0)

pipe2 =3D [r for r in self.results if "Reader Pipe" in r]
for p in pipe2:
      nmiss =3D p.split(" ")[7]
      if int(nmiss):
          raise error.TestError('\nBUG: rcutorture tests failed !')
          sys.exit(0)

I will double check on this.

Thanks
-Sachin=
