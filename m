Return-Path: <glikely@gmail.com>
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.194])
	by ozlabs.org (Postfix) with ESMTP id 2E87D679E0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Mar 2006 17:36:42 +1100 (EST)
Received: by nproxy.gmail.com with SMTP id p77so51912nfc
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 09 Mar 2006 22:36:40 -0800 (PST)
Message-ID: <528646bc0603092236t75b20124xeb7c84e1959056d@mail.gmail.com>
Date: Thu, 9 Mar 2006 23:36:40 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Andrei Konovalov" <akonovalov@ru.mvista.com>
Subject: Re: [Patch] Fix compile error for ML300/403
In-Reply-To: <44102EB3.2000301@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <528646bc0603081507t24c7e2f5u8e2823931200a857@mail.gmail.com>
	<44102EB3.2000301@ru.mvista.com>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 3/9/06, Andrei Konovalov <akonovalov@ru.mvista.com> wrote:
> > diff --git a/arch/ppc/platforms/4xx/virtex.h b/arch/ppc/platforms/4xx/v=
irtex.h
> > index 2a2a65c..4d893ef 100644
> > --- a/arch/ppc/platforms/4xx/virtex.h
> > +++ b/arch/ppc/platforms/4xx/virtex.h
> > @@ -27,7 +27,7 @@
> >  /* Device type enumeration for platform bus definitions */
> >  #ifndef __ASSEMBLY__
> >  enum ppc_sys_devices {
> > -       VIRTEX_UART, VIRTEX_FB,
> > +       VIRTEX_UART, VIRTEX_FB, NUM_PPC_SYS_DEVS,
>
> AFAIK there is no VIRTEX_FB in the powerpc.git tree yet.
> Otherwise I confirm that adding NUM_PPC_SYS_DEVS is necessary.

heh, oops.  yeah, I've got the FB driver in my local tree.  Fixed
patch attached...

-----

[patch] Fix compile error for ML300/403.

Due to changes in ppc_sys.c.  This is needed in Paul's powerpc.git tree

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

---
commit 60a9fb927e8f68d307339e6e268452d2c62b717f
tree e62d99cb4fa697d8d59af2a3ab063e050ba6ca99
parent 6749c5507388f3fc3719f57a54b540ee83f6661a
author Grant Likely <grant.likely@secretlab.ca> Wed, 08 Mar 2006 16:03:56 -=
0700
committer <grant@weasley-twins.(none)> Thu, 09 Mar 2006 23:30:38 -0700

 arch/ppc/platforms/4xx/virtex.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/ppc/platforms/4xx/virtex.h b/arch/ppc/platforms/4xx/virte=
x.h
index 1a01b81..c14325d 100644
--- a/arch/ppc/platforms/4xx/virtex.h
+++ b/arch/ppc/platforms/4xx/virtex.h
@@ -27,7 +27,7 @@
 /* Device type enumeration for platform bus definitions */
 #ifndef __ASSEMBLY__
 enum ppc_sys_devices {
-       VIRTEX_UART,
+       VIRTEX_UART, NUM_PPC_SYS_DEVS,
 };
 #endif
