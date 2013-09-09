Return-Path: <int0dster@gmail.com>
Received: from mail-qe0-x234.google.com (mail-qe0-x234.google.com
 [IPv6:2607:f8b0:400d:c02::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 688072C0129
 for <linuxppc-dev@ozlabs.org>; Tue, 10 Sep 2013 01:19:55 +1000 (EST)
Received: by mail-qe0-f52.google.com with SMTP id i11so3368172qej.39
 for <linuxppc-dev@ozlabs.org>; Mon, 09 Sep 2013 08:19:52 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 9 Sep 2013 08:19:52 -0700
Message-ID: <CAF10W3yi6UOjDN+Nh61OvOvVe6+veaFuXuz_Rx=oWsxPVRDYHQ@mail.gmail.com>
Subject: big latency while under HV
From: Ivan Krivonos <int0dster@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

i`m working on the embedded hypervisor targeting QorIQ platforms (p3041/p4080).
I have working prototype starting custom RTOS on just single core in the guest
space. What I see is the big latency (up to 3 times more) in RTOS running atop
of HV comparing to RTOS running bare-metal. I`m using lmbench utility.
It shows

nteger mul: 3.48 nanoseconds
integer div: 30.44 nanoseconds
integer mod: 13.92 nanoseconds
int64 bit: 1.75 nanoseconds
int64 add: 1.42 nanoseconds
int64 mul: 6.95 nanoseconds
HV:hvpriv_count 60000
int64 div: 447.56 nanoseconds
int64 mod: 385.42 nanoseconds
float add: 7.12 nanoseconds
float mul: 6.95 nanoseconds
float div: 33.05 nanoseconds
double add: 7.11 nanoseconds
double mul: 8.70 nanoseconds
double div: 57.36 nanoseconds
float bogomflops: 46.98 nanoseconds
double bogomflops: 73.09 nanoseconds

The bare-metal results are 3x better. Does anybody have any ideas on what
may be the source of such latency ? I forward all the exceptions to
the guest w/o
affecting HV. Only hvpriv is processed, it takes not more than 2 bus cycles.
Sorry for poor english
