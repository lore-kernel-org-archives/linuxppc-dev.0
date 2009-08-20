Return-Path: <akpm@linux-foundation.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1306CB7B6F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 08:03:04 +1000 (EST)
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2F417DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 08:03:02 +1000 (EST)
Date: Thu, 20 Aug 2009 15:02:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: linux-fsdevel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [Bugme-new] [Bug 14021] New: hfsplus caused data loss
Message-Id: <20090820150242.a4b5eccc.akpm@linux-foundation.org>
In-Reply-To: <bug-14021-10286@http.bugzilla.kernel.org/>
References: <bug-14021-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: rbrito@ime.usp.br, bugzilla-daemon@bugzilla.kernel.org,
	bugme-daemon@bugzilla.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Thu, 20 Aug 2009 02:17:21 GMT
bugzilla-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=14021
> 
>            Summary: hfsplus caused data loss
>            Product: File System
>            Version: 2.5
>     Kernel Version: 2.6.31-rc5
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: HFS/HFSPLUS
>         AssignedTo: zippel@linux-m68k.org
>         ReportedBy: rbrito@ime.usp.br
>         Regression: Yes
> 
> 
> Hi.
> 
> I am trying to package a new version of Apple's own fsck/mkfs for HFS+
> filesystems so that they can be used in Linux as a way to transfer data among
> computers, but I had quite a surprise when I was using the hfsplus module.
> 
> I just created a 100MB file with nulls (dd if=/dev/null ...) and I created an
> HFS+ filesystem on it.
> 
> Then, I loop mounted it and tried to use it a little bit (in particular,
> applying patches with quilt on a source tree). The commands spit some errors
> about not being able to create links (I never had that problem before) and the
> directory where I was became empty!
> 
> Furthermore, here is a quite, quite strange directory listing:
> 
> ,----
> | rbrito@chagas:/media/usb7$ ls -lAF
> | ls: hfsprogs_332.14-7.diff.gz: No such file or directory
> | ls: hfsprogs_332.14-7.dsc: No such file or directory
> | ls: hfsprogs_332.14.orig.tar.gz: No such file or directory
> | ls: hfsprogs_332.18-1.diff.gz: No such file or directory
> | ls: hfsprogs_332.18-1.dsc: No such file or directory
> | ls: hfsprogs_332.18-1_amd64.changes: No such file or directory
> | ls: hfsprogs_332.18-1_amd64.deb: No such file or directory
> | ls: hfsprogs_332.18.orig.tar.gz: No such file or directory
> | total 1636
> | drwxr-xr-x 1 rbrito rbrito     39 Aug 17 08:13 hfsprogs-332.14/
> | drwxr-xr-x 1 rbrito rbrito     39 Aug 17 08:13 hfsprogs-332.14/
> | drwxr-xr-x 1 rbrito rbrito     45 Aug 17 15:30 hfsprogs-332.18/
> | -rw-r--r-- 1 rbrito rbrito  35609 Aug 17 08:13 hfsprogs_332.14-7.diff.gz
> | -rw-r--r-- 1 rbrito rbrito   1193 Aug 17 08:13 hfsprogs_332.14-7.dsc
> | -rw-r--r-- 1 rbrito rbrito 714035 Aug 17 08:13 hfsprogs_332.14.orig.tar.gz
> | -rw-r--r-- 1 rbrito rbrito  35342 Aug 17 15:26 hfsprogs_332.18-1.diff.gz
> | -rw-r--r-- 1 rbrito rbrito    954 Aug 17 15:26 hfsprogs_332.18-1.dsc
> | -rw-r--r-- 1 rbrito rbrito   2148 Aug 17 15:26
> hfsprogs_332.18-1_amd64.changes
> | -rw-r--r-- 1 rbrito rbrito 135398 Aug 17 15:26 hfsprogs_332.18-1_amd64.deb
> | -rw-r--r-- 1 rbrito rbrito 732449 Aug 17 08:35 hfsprogs_332.18.orig.tar.gz
> | rbrito@chagas:/media/usb7$
> `----
> 
> I am using kernel 2.6.31-rc5-1rb.pre6 (that is, rc5 with git updates up to one
> or two days before rc6).
> 
> There are no messages in the dmesg, besides these:
> 
> ,----
> | [30991.501804] loop: module loaded
> | [30991.513337] hfs: create hidden dir...
> | [39897.867830] hfs: create hidden dir...
> | [39960.061622] hfs: splitting index node...
> `----
> 
> No stack traces, no nothing. Oh, I still have the disk image that I created, if
> it is of any interest.
> 
> Please let me know if I can provide any further information.
> 

Gee.  Nobody really does much maintenance work on hfs/hfsplus any more.
I cc'ed the ppc guys as I expect that most HFS users are over there.

It seems like a pretty gross failure - others should be hitting it.

I wonder if it's a weird interaction with the loop driver.
