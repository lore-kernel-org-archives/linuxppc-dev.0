Return-Path: <carlos.mitidieri@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 1AE4D679EB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Mar 2006 22:56:42 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.sysgo.com (Postfix) with ESMTP id E801BFB881
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Mar 2006 12:56:33 +0100 (CET)
Received: from donald.sysgo.com (unknown [172.20.1.30])
	by mail.sysgo.com (Postfix) with ESMTP id CAE11FB881
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Mar 2006 12:56:33 +0100 (CET)
Received: from cam (unknown [172.40.1.200])
	by donald.sysgo.com (Postfix) with ESMTP id F02612016DC
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Mar 2006 12:56:32 +0100 (CET)
From: Carlos Mitidieri <carlos.mitidieri@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Stable Linux kernel 2.6 for MPC8XX
Date: Tue, 14 Mar 2006 12:56:24 +0100
References: <20060310153341.080163525CB@atlas.denx.de>
	<200603140850.47014.david.jander@protonic.nl>
In-Reply-To: <200603140850.47014.david.jander@protonic.nl>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_p9qFEshaJsSESxM"
Message-Id: <200603141256.25652.carlos.mitidieri@sysgo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Boundary-00=_p9qFEshaJsSESxM
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, 

It seems that the nbench is not the most appropriate suit for comparing OSs 
(or OS versions), since its programs exercise only the CPU/memory 
subs-system. More suitable for comparing OSs are suites like unixbench and 
lmbench, which include many programs that exercise the OS calls/services.

Please find attached the results I have obtained when running the 
unixbench-4.1.0 for the kernels 2.4.26  and 2.6.14.  The 2.4.26 has better 
indexes for 5 of the 6 tests from unixbench that I have run.  

On Tuesday 14 March 2006 08:50, David Jander wrote:
> On Friday 10 March 2006 16:33, Wolfgang Denk wrote:
> > > I believe most of those observations and measurements are not valid
> > > anymore. Kernel 2.6 for 8xx has come a long way since this article was
> > > written. It might have been true back then, but it surely isn't
> > > anymore.
> >
> > So did you actually run any benchmarks? Specilations on what might be
> > or should be are not really helpful.
>
> Of course I did. Otherwise I wouldn't say this.
>
> Here's some benchmark data from nbench (sorry didn't try lmbench yet):
>
> The same ELDK (version 3.1.1) for both kernels, running on exactly the same
> board (MPC852T 100MHz, with 32Mbyte SDRAM and 32Mbyte Flash running from
> NFS root). I removed some FPU benchmarks, as they are pretty meaningless
> for this board and take an ethernity otherwise.


Best regards,
-- 
Carlos Mitidieri
SYSGO AG - Office Ulm

--Boundary-00=_p9qFEshaJsSESxM
Content-Type: text/plain;
  charset="iso-8859-1";
  name="unixbench-2.4.26"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="unixbench-2.4.26"


  BYTE UNIX Benchmarks (Version 4.1.0)
  System -- Linux 2.4.26 Tue Mar 7 08:56:57 CET 2006 ppc unknown
  Start Benchmark Run: Thu Jan  1 01:13:27 UTC 1970
    1:13am  up  1:13, load average: 0.07, 0.73, 0.80
  lrwxrwxrwx    1 root     root            9 Jan  1 00:00 /bin/sh -> /bin/bash
System Call Overhead                     243637.1 lps   (10.0 secs, 10 samples)
Pipe Throughput                          246562.1 lps   (10.0 secs, 10 samples)
Pipe-based Context Switching             114521.0 lps   (10.0 secs, 10 samples)
Process Creation                           2199.0 lps   (30.0 secs, 3 samples)
Execl Throughput                            362.8 lps   (29.7 secs, 3 samples)
Shell Scripts (1 concurrent)                680.0 lpm   (60.0 secs, 3 samples)
Shell Scripts (8 concurrent)                 92.0 lpm   (60.0 secs, 3 samples)
Shell Scripts (16 concurrent)                46.0 lpm   (60.0 secs, 3 samples)


                     INDEX VALUES            
TEST                                        BASELINE     RESULT      INDEX

Execl Throughput                                43.0      362.8       84.4
Pipe Throughput                              12440.0   246562.1      198.2
Pipe-based Context Switching                  4000.0   114521.0      286.3
Process Creation                               126.0     2199.0      174.5
Shell Scripts (8 concurrent)                     6.0       92.0      153.3
System Call Overhead                         15000.0   243637.1      162.4
                                                                 =========
     FINAL SCORE                                                     165.8

--Boundary-00=_p9qFEshaJsSESxM
Content-Type: text/plain;
  charset="iso-8859-1";
  name="unixbench-2.6.14"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="unixbench-2.6.14"


  BYTE UNIX Benchmarks (Version 4.1.0)
  System -- Linux 2.6.14 Tue Mar 7 12:50:28 CET 2006 ppc unknown
  Start Benchmark Run: Thu Jan  1 00:06:12 UTC 1970
   12:06am  up 6 min, load average: 0.00, 0.00, 0.00
  lrwxrwxrwx    1 root     root            9 Jan  1 00:00 /bin/sh -> /bin/bash
System Call Overhead                     339524.9 lps   (10.0 secs, 10 samples)
Pipe Throughput                          236842.6 lps   (10.0 secs, 10 samples)
Pipe-based Context Switching             106498.2 lps   (10.0 secs, 10 samples)
Process Creation                           1873.8 lps   (30.0 secs, 3 samples)
Execl Throughput                            372.6 lps   (29.8 secs, 3 samples)
Shell Scripts (1 concurrent)                650.4 lpm   (60.0 secs, 3 samples)
Shell Scripts (8 concurrent)                 88.0 lpm   (60.0 secs, 3 samples)
Shell Scripts (16 concurrent)                44.0 lpm   (60.0 secs, 3 samples)


                     INDEX VALUES            
TEST                                        BASELINE     RESULT      INDEX

Execl Throughput                                43.0      372.6       86.7
Pipe Throughput                              12440.0   236842.6      190.4
Pipe-based Context Switching                  4000.0   106498.2      266.2
Process Creation                               126.0     1873.8      148.7
Shell Scripts (8 concurrent)                     6.0       88.0      146.7
System Call Overhead                         15000.0   339524.9      226.3
                                                                 =========
     FINAL SCORE                                                     167.0

--Boundary-00=_p9qFEshaJsSESxM--
