Return-Path: <keescook@chromium.org>
Received: from mail-pf0-x235.google.com (mail-pf0-x235.google.com
 [IPv6:2607:f8b0:400e:c00::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcYWG1LTyzDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 08:55:38 +1100 (AEDT)
Received: by mail-pf0-x235.google.com with SMTP id w189so65501502pfb.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Mar 2017 13:55:38 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.kw@hitachi.com>,
 Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>,
 Tony Luck <tony.luck@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
 Matt Fleming <matt@codeblueprint.co.uk>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Geliang Tang <geliangtang@163.com>, linuxppc-dev@lists.ozlabs.org,
 linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: [PATCH 00/18] pstore: refactor internal APIs
Date: Mon,  6 Mar 2017 13:55:14 -0800
Message-Id: <1488837332-71582-1-git-send-email-keescook@chromium.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For a long time I've been bothered by the complexity of argument passing
in the pstore internals, which makes understanding things and changing
things extremely fragile.

With the proposal of a new backend (EPI capsules), and my attempts to
reorganize things for the proposed multiple-pmsg frontend, I've spent
some time refactoring the internal pstore API to pass a record structure
instead of lots of arguments. This hugely simplifies things, and lets me
document the API better, reduce memory copies, etc.

Included in the series are a few bug fixes as well.

If pstore backend authors could review the changes I've made in their
drivers, I'd appreciate it. Hopefully I got it all right. :) And unless
there are any objections, I'll put this into -next in a couple days.

I intend to continue working on this to fix up the "ecc_notification_size"
field and make it more generalized, and get multiple pmsg support added
too, but I'd like to get this first series out for review first, since
it's rather long already.

Thanks!

-Kees
