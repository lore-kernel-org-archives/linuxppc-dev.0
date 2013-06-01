Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E920C2C00A9
 for <linuxppc-dev@ozlabs.org>; Sat,  1 Jun 2013 15:26:09 +1000 (EST)
Message-ID: <1370064348.3766.37.camel@pasglop>
Subject: Re: [PATCH v3 0/8] Nvram-to-pstore
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Sat, 01 Jun 2013 15:25:48 +1000
In-Reply-To: <20130425100952.21017.51799.stgit@aruna-ThinkPad-T420>
References: <20130425100952.21017.51799.stgit@aruna-ThinkPad-T420>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: jkenisto@linux.vnet.ibm.com, tony.luck@intel.com, mahesh@linux.vnet.ibm.com,
 cbouatmailru@gmail.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 paulus@samba.org, anton@samba.org, ccross@android.com, keescook@chromium.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Another question...

Should the core pstore fail to unlink partitions that don't have
an ->erase callback ? IE. Why would you let anyone erase the OFW
common partition for example ? That means that userspace tools
can no longer manipulate it but we certainly don't want to remove
it from the nvram itself.

That leads to a deeper concern. Looking at how efi-pstore works,
it looks like they create a file for each var.

This looks like something valuable we could do for something like
the common partition since typically it's made of name,value pairs.

However, pstore is a flat space, while we have patitions which
themselves can be organized in name,value pairs (some at least)

I wonder if it's time to introduce pstore directories... Or do
we stick to our special tools to interpret/change the name,value
pairs ?

Also do we want to add an ability to resize partitions ? Possibly
based on how much is written to them ?

Cheers,
Ben.
