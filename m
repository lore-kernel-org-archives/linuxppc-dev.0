Return-Path: <paulus@ozlabs.org>
Date: Fri, 22 Feb 2013 16:03:27 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH -V2 02/21] powerpc: Save DAR and DSISR in pt_regs on
 MCE
Message-ID: <20130222050327.GB6139@drongo>
References: <1361465248-10867-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1361465248-10867-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1361465248-10867-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 21, 2013 at 10:17:09PM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> We were not saving DAR and DSISR on MCE. Save then and also print the values
> along with exception details in xmon.

The one reservation I have about this is that xmon will now be
printing bogus values on 32-bit and embedded processors.  However, it
seems 32-bit doesn't set regs->dar on a DSI (300) interrupt either.
So:

Acked-by: Paul Mackerras <paulus@samba.org>
