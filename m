Date: Sat, 24 Apr 2004 11:38:01 +0800
From: llee <llee@huawei.com>
Subject: question about 8241 again
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Message-id: <4089E119.40003@huawei.com>
MIME-version: 1.0
Content-type: text/plain; charset=GB18030; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi, all,

I get confusion on linux PPC MMU management(kernel 2.6.3): It seems
linux setup an empty hashtable (in MMU_init_hw) first and do a
hash_page() when exception. But at least it should make a real mapping
for the kernel itself, shouldn't it? But I haven't found it do this
anywhere.

And also, when i add the following code in sandpoint_map_io(and I also
enable feature CPU_FTR_HPTE_TABLE for 8241):
    io_block_mapping(0x70000000, 0x70000000, 0x20000000, _PAGE_IO);
    io_block_mapping(0x80500000, 0x80500000, 0x00100000, _PAGE_IO);
the first call get a bat mapping and another get a page mapping, but
only the first one works find, the second one could not been access.

Could anybody tell me why?

Thanks advanced and sorry for my poor english.

Ken

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
