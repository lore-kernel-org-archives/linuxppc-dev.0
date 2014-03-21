Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 547E92C0082
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2014 02:02:37 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 00759-03 for <linuxppc-dev@ozlabs.org>;
 Fri, 21 Mar 2014 15:02:35 +0000 (GMT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Viresh Kumar' <viresh.kumar@linaro.org>
Subject: RE: [PATCH v3 5/5] powernv:cpufreq: Implement the driver->get() method
Date: Fri, 21 Mar 2014 15:01:09 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D0F6E5677@AcuExch.aculab.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-6-git-send-email-ego@linux.vnet.ibm.com>
 <CAOh2x==9JT-q2w95Ub_Ck_UMPcWY_4vo_Y44-i=DPjtu0jxwZg@mail.gmail.com>
 <20140321110445.GB2493@in.ibm.com>
 <CAKohpo=k-e1GLiLRNtJ3Xi3+NUWW1+gvtCNr_4Ag60j49dZvdQ@mail.gmail.com>
 <063D6719AE5E284EB5DD2968C1650D6D0F6E5386@AcuExch.aculab.com>
 <CAKohpo=E1UEcLhbZHtmBJcD3S3trm8ypT7++quF_t6XHDXAvHA@mail.gmail.com>
In-Reply-To: <CAKohpo=E1UEcLhbZHtmBJcD3S3trm8ypT7++quF_t6XHDXAvHA@mail.gmail.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>,
 Linux PM list <linux-pm@vger.kernel.org>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Viresh Kumar [mailto:viresh.kumar@linaro.org]
> On 21 March 2014 17:31, David Laight <David.Laight@aculab.com> wrote:
> >> *(int *)ret_freq =3D freq;
> >
> > Because it is very likely to be wrong.
> > In general casts of pointers to integer types are dangerous.
>=20
> Where are we converting pointers to integers? We are doing a
> cast from 'void * ' to 'int *' and then using indirection operator
> to set its value.

You mis-parsed what I wrote, try:
In general casts of 'pointer to integer' types are dangerous.

Somewhere, much higher up the call stack, the address of an integer
variable is being taken and then passed as the 'void *' parameter.

The 'problem' is that it is quite easily to pass the address of
a 'long' instead. On 32bit and LE systems this won't always
be a problem. On 64bit BE it all goes wrong.

	David
