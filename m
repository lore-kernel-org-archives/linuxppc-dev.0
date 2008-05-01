Return-Path: <maynardj@us.ibm.com>
Message-ID: <4819EFEE.4040601@us.ibm.com>
Date: Thu, 01 May 2008 11:29:34 -0500
From: Maynard Johnson <maynardj@us.ibm.com>
MIME-Version: 1.0
To: Carl Love <cel@us.ibm.com>
Subject: Re: [PATCH] Updated: Reworked Cell OProfile: SPU mutex lock fix
References: <1209652994.17842.1.camel@carll-linux-desktop>
In-Reply-To: <1209652994.17842.1.camel@carll-linux-desktop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, oprofile-list <oprofile-list@lists.sf.net>,
	cbe-oss-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Carl Love wrote:
> Sorry, looks like my mailer mangled the file.
>
> This is a reworked patch to fix the SPU data storage.  Currently, the 
> SPU escape sequences and program counter data is being added directly 
> into the kernel buffer without holding the buffer_mutex lock.  This 
> patch changes how the data is stored.  A new function,
> oprofile_add_value, is added into the oprofile driver to allow adding
> generic data to the per cpu buffers.  This enables a series of calls
> to the oprofile_add_value to enter the needed SPU escape sequences 
> and SPU program data into the kernel buffer via the per cpu buffers
> without any additional processing. The oprofile_add_value function is
> generic so it could be used by other architecures as well provided
> the needed postprocessing was added to opreport.
>
> Finally, this patch backs out the changes previously added to the 
> oprofile generic code for handling the architecture specific 
> ops.sync_start and ops.sync_stop that allowed the architecture
> to skip the per CPU buffer creation.
>
> Signed-off-by: Carl Love <carll@us.ibm.com>
>   
Looks fine to me.  All of my previous review comments have been addressed.

-Maynard
[snip]
