Return-Path: <artunmurat@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.185])
	by ozlabs.org (Postfix) with ESMTP id 1984DDDE1B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Sep 2007 00:34:06 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id c10so2147653nfd
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Sep 2007 07:34:04 -0700 (PDT)
Message-ID: <4e5a3720709270734k54016e93h68ae6606d959cee9@mail.gmail.com>
Date: Thu, 27 Sep 2007 17:34:04 +0300
From: "Murat Artun" <artunmurat@gmail.com>
To: "Wolfgang Denk" <wd@denx.de>
Subject: Re: changing the EDLK components
In-Reply-To: <20070926232020.AD2B12405D@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4e5a3720709260725x6d2e9faemc6a6053379610df8@mail.gmail.com>
	<20070926232020.AD2B12405D@gemini.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ok, I have built my library from its source RPM as you have stated.

Specifically, I have followed the procedure in section "3.7.
Rebuilding ELDK Components". First I have installed source RPMs and
then rebuilt the binary target RPM. However, as I have followed the
compiler messages I recognized that host gcc is called instead of
cross gcc.

Considering that my PATH was set following the advice in section "3.7.
Rebuilding ELDK Components" as "<ELDK_root>/usr/ppc-linux/bin"
directory is before "/usr/bin" what could be the problem?

Thanks and regards...

On 9/27/07, Wolfgang Denk <wd@denx.de> wrote:
> In message <4e5a3720709260725x6d2e9faemc6a6053379610df8@mail.gmail.com> you wrote:
> >
> > I want to learn the way of building a GNU Automake project and adding
> > it into ELDK. This could be needed because the current version of an
> > ELDK component is old to meet the requirements or a library which is
> > not an ELDK component is to be used in our ppc system.
>
> In  principle,  this  is  a  pretty  straightforward  procedure:  you
> download   the   source   RPM   (for   example,  from  the  Fedora  7
> distribution), and use the "rpmbuild" command on the  native  syustem
> (running  with  root  file  system  mounted  over  NFS  or on a local
> harddisk) to build the stuff. For example:
>
> $ rpmbuild --rebuild automake17-1.7.9-8.src.rpm
>
> That's in proinciple. In  reality,  you  will  soon  learn  that  the
> package  has  a  lot  of  build  dependencies,  which are not exactly
> trivial to resolve, as some of them are circular. You can try and find
> what's really needed (and not included with the ELDK) by running
>
> $ rpmbuild --rebuild --nodeps automake17-1.7.9-8.src.rpm
>
> but this is just tof ind out how many othe rpackages youw ill need to
> build before...
>
> > As now, I need to upgrade an ELDK component. Namely, I need version
> > 0.9.8 of OpenSSL, where latest ELDK release has OpenSSL with version
> > 0.9.7f. I want to learn if it is necessary for me to follow the same
>
> You don't need a native version of automake for this, as  builing  is
> done  in  the  cross  environment,  and  we  assume you have automake
> installed on your build host.
>
> > procedure stated in documentation in section "3.7. Rebuilding ELDK
> > Components". If this is the case, could anyone point me to resources
> > about how to prepare source rpms from an Automake project to prepare
>
> I don't understand why you mention automake here. It is completely
> unrelated.
>
> > the source rpm of version 0.9.8 of OpenSSL? Of course building the new
> > version of the component and placing everything by hand is always a
> > solution, but I want to understand the clean way of doing this.
>
> The clean way is to adjust the ELDK buld system for the new  version.
> This  is  usually  a  non-trivial  job. By doing it you will start to
> admire what ELDK gives you and understand at least a bit of how  much
> effort is built into it - and you get it all completely for free...
>
>
>
> Alternatively, you can just wait for ELDK 4.2, which will include
> openssl-0.9.8b-12
>
> Best regards,
>
> Wolfgang Denk
>
> --
> DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> That Microsoft, the Trabant of the operating  system  world,  may  be
> glancing  over the Berlin Wall at the Audis and BMWs and Mercedes. In
> their own universe Trabants and Ladas were mainstream too...
>                                                    -- Evan Leibovitch
>


-- 
M u r at  A r t u n, MSc.
   Design Engineer

"be conservative in what you do, be liberal in what you accept from others"
