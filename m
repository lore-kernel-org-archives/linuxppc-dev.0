Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CAB471A0025
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 18:46:28 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org
Subject: Re: [Y2038] [PATCH 05/11] time/posix-timers:Convert to the 64bit
 methods for k_clock callback functions
Date: Tue, 21 Apr 2015 10:45:48 +0200
Message-ID: <8072977.i0FsrGW3CD@wuerfel>
In-Reply-To: <CAMz4kuKF2sU4tMD7UtDobu2kVDMp7cfHNERSPQ9Yyzs80tOzYg@mail.gmail.com>
References: <1429509459-17068-1-git-send-email-baolin.wang@linaro.org>
 <alpine.DEB.2.11.1504202243070.13914@nanos>
 <CAMz4kuKF2sU4tMD7UtDobu2kVDMp7cfHNERSPQ9Yyzs80tOzYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Xunlei Pang <pang.xunlei@linaro.org>, peterz@infradead.org,
 heiko.carstens@de.ibm.com, paulus@samba.org, cl@linux.com,
 Heena Sirwani <heenasirwani@gmail.com>, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, rafael.j.wysocki@intel.com,
 Andrew Hunter <ahh@google.com>,
 =?ISO-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
 Paul Turner <pjt@google.com>, riel@redhat.com,
 Richard Cochran <richardcochran@gmail.com>, tj@kernel.org,
 John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
 rth@twiddle.net, Baolin Wang <baolin.wang@linaro.org>,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, schwidefsky@de.ibm.com, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 21 April 2015 16:36:13 Baolin Wang wrote:
> On 21 April 2015 at 04:48, Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > On Mon, 20 Apr 2015, Baolin Wang wrote:
> > >  /* Set clock_realtime */
> > >  static int posix_clock_realtime_set(const clockid_t which_clock,
> > > -                                 const struct timespec *tp)
> > > +                                 const struct timespec64 *tp)
> > >  {
> > > -     return do_sys_settimeofday(tp, NULL);
> > > +     struct timespec ts = timespec64_to_timespec(*tp);
> > > +
> > > +     return do_sys_settimeofday(&ts, NULL);
> >
> > Sigh. No. We first provide a proper function for this, which takes a
> > timespec64, i.e. do_sys_settimeofday64() instead of having this
> > wrapper mess all over the place.
> >
> 
> Thanks for your comments,but if use do_sys_settimeofday64() here that
> will  introduce
> a security bug: do_sys_settimeofday contains a capability
> check that normally prevents non-root users from setting the time.
> 
> With your change, any user can set the system time.

He was asking for a new do_sys_settimeofday64 function to be added,
not using the low-level do_settimeofday64.

	Arnd
