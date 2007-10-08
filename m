Return-Path: <ralferoo@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 91052DDF8D
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 08:59:15 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so120736anc
	for <linuxppc-dev@ozlabs.org>; Mon, 08 Oct 2007 15:59:14 -0700 (PDT)
Message-ID: <18a15270710081559m3236126r85f797718300756f@mail.gmail.com>
Date: Mon, 8 Oct 2007 23:59:14 +0100
From: "Ranulf Doswell" <ralf@ranulf.net>
Sender: ralferoo@gmail.com
To: "Geoff Levand" <geoffrey.levand@am.sony.com>
Subject: Re: [patch 6/6] PS3: Add os-area database routines
In-Reply-To: <470A6E4E.5090009@am.sony.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2310_23461147.1191884354227"
References: <20071006213542.311447584@am.sony.com>
	<20071006213542.954029915@am.sony.com>
	<18a15270710080648x3b5f1135meea3d7b048a1a543@mail.gmail.com>
	<470A6E4E.5090009@am.sony.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_2310_23461147.1191884354227
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 08/10/2007, Geoff Levand <geoffrey.levand@am.sony.com> wrote:
>
> > How do we go about claiming one of these OS_AREA_DB_OWNER_ keys? I'd
> > very much like to use this functionality in my python-ps3 games library.
>
> It sounds like you should be storing your info in the file system like
> all other applications do.


I'd agree that for large amounts of application specific data, the
filesystem is the correct approach.

However, in this case the only data required is a single identifier used to
identify one PS3 from another, and in fact this single 64-bit token can be
shared amongst many other applications that require the same function -
certainly I intend to expose it in a common way in my games library's API
for all users of the library.

In my particular case, my bootable CD image does not have any other use for
a filesystem on disk beyond the initrd image on the CD-ROM; this is
important because some PS3s may be formatted as 100% GameOS. All that is
needed is to write the standard kboot image to flash so that it is able to
bootstrap the CD image.

As the PS3 has flash available and you are adding a mechanism for storing
very small bits of data in the flash, it seems silly not to use it and
attempt instead to write my own incompatible database format to store this
in the flash memory. Your database also has the added protection of not
being overwritten when the loader is re-flashed, as it is protected by the
kernel.

If you agree in principle that one of these identifiers can be allocated to
this purpose, I'm happy to write and submit a patch that exposes the get/set
system ID functionality to userland, whilst internally using your database.
This could also allow for some of the bits to be used as check bits to
ensure data validity.

Possibly there already exists a way to obtain a hash of the serial number or
some other unique identifying token via one of the undocumented hypervisor
calls, but as I'm not privvy to that kind of information I need to roll my
own mechanism for doing this.

Ralf.

------=_Part_2310_23461147.1191884354227
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 08/10/2007, <b class="gmail_sendername">Geoff Levand</b> &lt;<a href="mailto:geoffrey.levand@am.sony.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">geoffrey.levand@am.sony.com</a>&gt; wrote:
<div><span class="gmail_quote"></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
&gt; How do we go about claiming one of these OS_AREA_DB_OWNER_ keys? I&#39;d<br>&gt; very much like to use this functionality in my python-ps3 games library.<br><br>It sounds like you should be storing your info in the file system like
<br>all other applications do.</blockquote><div><br>I&#39;d agree that for large amounts of application specific data, the filesystem is the correct approach.<br><br>However, in this case the only data required is a single identifier used to identify one PS3 from another, and in fact this single 64-bit token can be shared amongst many other applications that require the same function - certainly I intend to expose it in a common way in my games library&#39;s  API for all users of the library.
<br><br>In my particular case, my bootable CD image does not have any other use for a filesystem on disk beyond the initrd image on the CD-ROM; this is important because some PS3s may be formatted as 100% GameOS. All that is needed is to write the standard kboot image to flash so that it is able to bootstrap the CD image.
<br><br>As the PS3 has flash available and you are adding a mechanism for storing very small bits of data in the flash, it seems silly not to use it and attempt instead to write my own incompatible database format to store this in the flash memory. Your database also has the added protection of not being overwritten when the loader is re-flashed, as it is protected by the kernel.
<br></div><br>If you agree in principle that one of these identifiers can be allocated to this purpose, I&#39;m happy to write and submit a patch that exposes the get/set system ID functionality to userland, whilst internally using your database. This could also allow for some of the bits to be used as check bits to ensure data validity.
<br><br>Possibly there already exists a way to obtain a hash of the serial number or some other unique identifying token via one of the undocumented hypervisor calls, but as I&#39;m not privvy to that kind of information I need to roll my own mechanism for doing this.
<br><br>Ralf.<br clear="all"></div>

------=_Part_2310_23461147.1191884354227--
