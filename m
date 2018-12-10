Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31643C5CFFE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 23:35:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C5892082F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 23:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C5892082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DKF04HzXzDqpM
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 10:35:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=sbobroff@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DKBf1fLfzDqjk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 10:33:13 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBANOJbZ105408
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 18:33:11 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2pa0bykkt7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 18:33:11 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Mon, 10 Dec 2018 23:33:09 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 10 Dec 2018 23:33:06 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wBANX5Kg57540834
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Dec 2018 23:33:05 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E4CEA405C;
 Mon, 10 Dec 2018 23:33:05 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 988BDA4054;
 Mon, 10 Dec 2018 23:33:04 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 10 Dec 2018 23:33:04 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (unknown [9.102.46.41])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id BED92A0173;
 Tue, 11 Dec 2018 10:33:02 +1100 (AEDT)
Date: Tue, 11 Dec 2018 10:33:01 +1100
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: Oliver <oohall@gmail.com>
Subject: Re: [PATCH] powerpc: eeh_event: convert semaphore to completion
References: <20181210215203.1936171-1-arnd@arndb.de>
 <CAOSf1CHqxaGdz_F0EifqHmD+0ZgKVno7aRZEXUG1880C5YvHGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <CAOSf1CHqxaGdz_F0EifqHmD+0ZgKVno7aRZEXUG1880C5YvHGQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-TM-AS-GCONF: 00
x-cbid: 18121023-0008-0000-0000-0000029F87B5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121023-0009-0000-0000-00002209FDEA
Message-Id: <20181210233300.GA14707@tungsten.ozlabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-10_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812100210
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Arnd Bergmann <arnd@arndb.de>, aik@ozlabs.ru,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 10:18:31AM +1100, Oliver wrote:
> On Tue, Dec 11, 2018 at 8:52 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > For this use case, completions and semaphores are equivalent,
> > but semaphores are an awkward interface that should generally
> > be avoided, so use the completion instead.
>=20
> IIRC Sam has been reworking the locking used inside of EEH so this is
> probably going to clash with his changes. Converting to a completion
> is probably a good idea, but we might want to do it as a part of his
> series since it's going to collide with this anyway.
>=20
> Sam, what do you think?

It's such a small change, I don't think it will cause any problems for
the rework. Anyway it seems like a good change, so I'd prefer to see it
go in :-)

Cheers,
Sam.

> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/powerpc/kernel/eeh_event.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/eeh_event.c b/arch/powerpc/kernel/eeh_=
event.c
> > index 61c9356bf9c9..227e57f980df 100644
> > --- a/arch/powerpc/kernel/eeh_event.c
> > +++ b/arch/powerpc/kernel/eeh_event.c
> > @@ -35,7 +35,7 @@
> >   */
> >
> >  static DEFINE_SPINLOCK(eeh_eventlist_lock);
> > -static struct semaphore eeh_eventlist_sem;
> > +static DECLARE_COMPLETION(eeh_eventlist_event);
> >  static LIST_HEAD(eeh_eventlist);
> >
> >  /**
> > @@ -55,7 +55,7 @@ static int eeh_event_handler(void * dummy)
> >         struct eeh_pe *pe;
> >
> >         while (!kthread_should_stop()) {
> > -               if (down_interruptible(&eeh_eventlist_sem))
> > +               if (wait_for_completion_interruptible(&eeh_eventlist_ev=
ent))
> >                         break;
> >
> >                 /* Fetch EEH event from the queue */
> > @@ -102,9 +102,6 @@ int eeh_event_init(void)
> >         struct task_struct *t;
> >         int ret =3D 0;
> >
> > -       /* Initialize semaphore */
> > -       sema_init(&eeh_eventlist_sem, 0);
> > -
> >         t =3D kthread_run(eeh_event_handler, NULL, "eehd");
> >         if (IS_ERR(t)) {
> >                 ret =3D PTR_ERR(t);
> > @@ -142,7 +139,7 @@ int eeh_send_failure_event(struct eeh_pe *pe)
> >         spin_unlock_irqrestore(&eeh_eventlist_lock, flags);
> >
> >         /* For EEH deamon to knick in */
> > -       up(&eeh_eventlist_sem);
> > +       complete(&eeh_eventlist_event);
> >
> >         return 0;
> >  }
> > --
> > 2.20.0
> >
>=20

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAlwO96YACgkQMX8w6AQl
/iKCvwf/QsZpJRkrj9J6Kg5f36kvI3ntwmLJbWMt6w/GtQzVcwIizQLRH84mAjNv
vQBON2d0gPM8QO1sdaA/Ilu0/LQIFG90NIAZWowX/8Leq0gmwAI9gO1zn15wWOjl
NoRboPfBuhi7SzM9XJDf/YXuj7sLCBbKU9Tbj7BDn9cgF+RWxxVsQSHYO2O7LjrW
HlPTJBotLzCE+ucI3yc6O0dimjZ4K6uLrNuzPTBSSg9OxY6GqTLF2NR51M+lLdSA
YpEBhWLFFiXfr6uGeE+RyIqD50QER4HNW7PPF5pG0RyVRGx4zYvHcRXKV/V5Rx/f
xYoJX1OL7THp/VdRBX99OdpcjK9E5Q==
=4vZx
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--

