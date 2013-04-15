Return-Path: <michael@ellerman.id.au>
Date: Mon, 15 Apr 2013 17:31:38 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/8] Add version and timestamp to oops header
Message-ID: <20130415073138.GB30156@concordia>
References: <20130410071835.20150.56489.stgit@aruna-ThinkPad-T420>
 <20130410072112.20150.10281.stgit@aruna-ThinkPad-T420>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130410072112.20150.10281.stgit@aruna-ThinkPad-T420>
Cc: jkenisto@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 10, 2013 at 12:51:12PM +0530, Aruna Balakrishnaiah wrote:
> Introduce version and timestamp information in the oops header.
> oops_log_info (oops header) holds version (to distinguish between old
> and new format oops header), length of the oops text
> (compressed or uncompressed) and timestamp.

This needs a much more detailed explanation.

I think what you're doing is you're overlaying the new information so
that the version field in oops_log_info sits in the same location as the
length field in the old format. And then you're defining the version to
be a value that is an illegal length.

So existing tools will refuse to dump new style partitions,
because they'll think the length is too large. You've tested that?

Updated tools will know about both formats, so will be able to handle
either old or new style partitions.

Is that correct?

And we're adding the timestamp just because we can and it'd be nice to
have?

cheers
