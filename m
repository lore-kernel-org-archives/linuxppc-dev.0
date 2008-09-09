Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 7237ADDF4A
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Sep 2008 20:06:31 +1000 (EST)
Date: Tue, 9 Sep 2008 14:06:28 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Junio C Hamano <gitster@pobox.com>
Subject: Re: git apply vs. renamed files index mismatch
Message-ID: <20080909100628.GA15298@oksana.dev.rtsoft.ru>
References: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-2-git-send-email-becky.bruce@freescale.com>
	<48C57A92.6060608@freescale.com>
	<20080908212717.GA21338@oksana.dev.rtsoft.ru>
	<7vej3ucf6y.fsf@gitster.siamese.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <7vej3ucf6y.fsf@gitster.siamese.dyndns.org>
Cc: Scott Wood <scottwood@freescale.com>, git@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 08, 2008 at 05:53:41PM -0700, Junio C Hamano wrote:
> Anton Vorontsov <avorontsov@ru.mvista.com> writes:
> 
> >>>  3 files changed, 201 insertions(+), 201 deletions(-)
> >>>  create mode 100644 arch/powerpc/kernel/dma.c
> >>>  delete mode 100644 arch/powerpc/kernel/dma_64.c
> >>
> >> Passing -M to git format-patch makes it much easier
> >
> > I always thought that posting "-M" patches to the public lists is
> > discouraged since it is quite difficult to apply them via patch(1).
> > Also think of non-git users...
> 
> My understanding has been that it is encouraged on the kernel mailing
> list, because the rename format is far easier to review by showing the
> differences that matter to reviewers, than showing a big chunk of text
> deleted and another big chunk of text that is similar added elsewhere.
> 
> I won't comment on this any further; the use of it is strictly a list and
> community policy issue.
> 
> > This is still possible by comparing the hashes:
> > ...
> > That is, if hashes match then it was pure rename.
> >
> > Though, too bad git {apply,am} does not produce any warnings if there
> > are any hidden changes...
> 
> But I _do_ want to know what you mean by this comment.  Your statement
> makes it sounds as if apply/am happily and silently accept "hidden
> changes" and it is a bad thing.
> 
> Now what do you exactly mean by "any hidden changes"?  Do you mean "the
> sender did not use renaming format, the patch you fed was a one that
> removes a huge chunk of text from one file, and adds a similarly huge
> chunk of text to another file.  The changes to these files looked similar
> but was not quite the same"?  It is all there for you to review, and
> especially if you prefer non-renaming format, then that is what you get.

As I said, "index .." lines that git puts into patches are useful to see
if there any changes has been made to a renamed file. So usually I don't
have to look through the whole patch to see if there are any changes,
I can just look into the patch and conclude: "this is git patch, and the
overhead information says that it is rename-only patch. It should
be safe."

Now consider the following patch (modified by hand: it should say
+foo, but I changed it to +bar).

diff --git a/file b/file
deleted file mode 100644
index 257cc56..0000000
--- a/file
+++ /dev/null
@@ -1 +0,0 @@
-foo
diff --git a/file_renamed b/file_renamed
new file mode 100644
index 0000000..257cc56
--- /dev/null
+++ b/file_renamed
@@ -0,0 +1 @@
+bar


The "index ..." stuff says that there are no changes and it is
pure rename, but obviously there is a change.

What would be great is to have is some warning (or error), that
is: "git-am: patch claims that it would only rename the file %s,
but it also changes things in that file. Somebody tried to make
a fool of you."

Makes sense?

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
