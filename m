Return-Path: <brijesh.singh@amd.com>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0047.outbound.protection.outlook.com [104.47.34.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xv16F16h7zDrYs
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Sep 2017 02:28:04 +1000 (AEST)
Cc: brijesh.singh@amd.com, Tom Lendacky <thomas.lendacky@amd.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
 David Laight <David.Laight@aculab.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Fenghua Yu <fenghua.yu@intel.com>, Matt Fleming <matt@codeblueprint.co.uk>,
 David Howells <dhowells@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Christoph Lameter <cl@linux.com>, Jonathan Corbet <corbet@lwn.net>,
 =?UTF-8?Q?Radim_Krcm=c3=a1r?= <rkrcmar@redhat.com>,
 Piotr Luc <piotr.luc@intel.com>, Ingo Molnar <mingo@redhat.com>,
 Dave Airlie <airlied@redhat.com>, Kees Cook <keescook@chromium.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Reza Arbab <arbab@linux.vnet.ibm.com>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Laura Abbott <labbott@redhat.com>,
 Tony Luck <tony.luck@intel.com>, Ard.Biesheuvel@zytor.com
Subject: Re: [RFC Part1 PATCH v3 13/17] x86/io: Unroll string I/O when SEV is
 active
To: Borislav Petkov <bp@suse.de>
References: <063D6719AE5E284EB5DD2968C1650D6DD003FB85@AcuExch.aculab.com>
 <CAK8P3a3h7JpmkW7W=HwqAuWWmro=ngj6HSeiiML_=T82x-FtZQ@mail.gmail.com>
 <ed6d4ce7-97a6-f664-d7d7-4ff48bc6f06a@amd.com>
 <201707261927.v6QJR228008075@mail.zytor.com>
 <589d65a4-eb09-bae9-e8b4-a2d78ca6b509@amd.com>
 <20170822165248.rkbluikdgduu7ucy@pd.tnic>
 <20170915122430.pnroy6vsg53warel@pd.tnic>
 <95314c89-2620-8bb7-cbe8-cd9bc3adabb0@amd.com>
 <20170915143935.6vtfp5rtj5h324fi@pd.tnic>
 <ad628a45-8e4e-9cfc-2cc4-33dc6bf4613a@amd.com>
 <20170915162256.7l4vyy4ee5zeqbir@pd.tnic>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <100e9186-c28e-1caa-4bd5-1a2624cc5c01@amd.com>
Date: Fri, 15 Sep 2017 11:27:48 -0500
MIME-Version: 1.0
In-Reply-To: <20170915162256.7l4vyy4ee5zeqbir@pd.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 09/15/2017 11:22 AM, Borislav Petkov wrote:
> mem_encrypt_init() where everything should be set up already.


Yep, its safe to derefs the static key in mem_encrypt_init(). I've
tried the approach and it seems to be work fine. I will include the
required changes in next rev. thanks
