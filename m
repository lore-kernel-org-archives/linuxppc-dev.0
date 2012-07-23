Return-Path: <paulus@ozlabs.org>
Date: Mon, 23 Jul 2012 19:39:51 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V3 11/11] arch/powerpc: Add 64TB support
Message-ID: <20120723093951.GB29264@bloggs.ozlabs.ibm.com>
References: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1341839621-28332-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1341839621-28332-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 09, 2012 at 06:43:41PM +0530, Aneesh Kumar K.V wrote:

> -#define USER_ESID_BITS		16
> -#define USER_ESID_BITS_1T	4
> +#define USER_ESID_BITS		18
> +#define USER_ESID_BITS_1T	6

You also need to change the proto-VSID generation for kernel addresses
when you do this.  If you don't you'll end up with some user processes
using the same VSIDs as we use for the kernel addresses, meaning that
those processes won't run very well...

Paul.
