Return-Path: <nwhitehorn@freebsd.org>
Subject: Re: Getting kernel 4.14 to run on PS3
To: Geoff Levand <geoff@infradead.org>,
 Sascha Schroeder <sascha.schroeder@aethyx.com>
Cc: Linuxppc-dev@lists.ozlabs.org, petitboot@lists.ozlabs.org
References: <9621b73a-12e0-1254-932c-2456238b5526@aethyx.com>
 <1dd3a437-a20e-c808-749c-4cdb7b9d3675@infradead.org>
 <4dadeca5-22dc-6ab1-961e-8f989b6f8699@freebsd.org>
 <5c41fd34-5aac-028e-af12-59b6ab576d91@infradead.org>
From: Nathan Whitehorn <nwhitehorn@freebsd.org>
Message-ID: <1a034ec1-5345-a2a1-780a-b5adbe0af332@freebsd.org>
Date: Sun, 31 Dec 2017 14:50:14 -0800
MIME-Version: 1.0
In-Reply-To: <5c41fd34-5aac-028e-af12-59b6ab576d91@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 12/12/17 15:05, Geoff Levand wrote:
> Hi Nathan,
>
> On 12/08/2017 01:25 PM, Nathan Whitehorn wrote:
>> I submitted patches to libfdt that resolve this particular ABI breakage yesterday. If the patch gets merged, newer kernels should become bootable again.
> Here's the link:
>
>    https://github.com/dgibson/dtc/pull/12 (Add limited read-only support for older (V2 and V3) device tree to libfdt.)
>
> I rebased your patch and have it in my ps3-queue
> branch, but my ps3 with ps3-petitboot-09.11.30 still
> would not boot with it.  I didn't spend any time yet
> to look into why.
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/geoff/ps3-linux.git/log/?h=ps3-queue
>
> -Geoff
>

I found a bug (and updated the pull request), which might help.

The other potential issue is that the fdt_get_property*() API in libfdt 
is fundamentally incompatible with the way that V2 device trees align 
data accesses since it returns a pointer to a packed structure with both 
the property header and data. However, the data in V2 devtrees may be 
offset by 4 bytes in a way that depends both on the offset within the 
tree and the length of the property and so cannot be represented only as 
the tail of a fixed structure. I don't know if Linux uses those 
functions; I had to replace two uses in FreeBSD with the equivalent 
fdt_getprop*() calls to get things to work.
-Nathan
