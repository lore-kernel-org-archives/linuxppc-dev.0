Return-Path: <afleming@freescale.com>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
 [213.199.154.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 9AA73B71EE
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2011 04:52:06 +1100 (EST)
Subject: Re: oprofile callgraph support missing for common cpus
MIME-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset="iso-8859-1"
From: Andy Fleming <afleming@freescale.com>
In-Reply-To: <4EC544C6.3050502@us.ibm.com>
Date: Thu, 17 Nov 2011 11:51:52 -0600
Message-ID: <A8CB2347-27B6-482A-B49B-F434FBFCBC10@freescale.com>
References: <OFD9ADD493.27DB131E-ONC125794B.002E2035-C125794B.002F715A@transmode.se>
 <4EC544C6.3050502@us.ibm.com>
To: <maynardj@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org, oprofile-list@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 17, 2011, at 11:30 AM, Maynard Johnson wrote:

>>=20
>> Notice the first
>> 		 if (!cur_cpu_spec->oprofile_cpu_type)
>> 		 		 return -ENODEV;
>>=20
>> 		 if (firmware_has_feature(FW_FEATURE_ISERIES))
>> 		 		 return -ENODEV;
>> For my e300c2 cpu both if's are false and I don't get support for =
callgraph/backtrace
>> support. Moving the ops->backtrace =3D op_powerpc_backtrace; to the =
top
>> enables backtrace for me.
> What kernel version are you using?  Actually, looking at a 3.0.3 tree =
I happen to have available, I see oprofile h/w event support (in =
arch/powerpc/kernel/cputable.c) for e300c3 and e300c4, but not the other =
e300 flavors.  I've added Andy Flemming from Freescale to cc.  Maybe he =
knows why e300c2 isn't supported.

e300c2 does not have hardware performance monitor events.

However, it should be able to support timer-based profiling, right? And =
why not support backtrace from there? Do we require hardware counters to =
get a backtrace?

Andy
