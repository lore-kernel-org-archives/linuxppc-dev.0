Subject: Proposal for device-tree walking semantics
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.linuxppc.org
Cc: Anton Blanchard <anton@samba.org>,
	Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Message-Id: <1056373513.9700.25.camel@gaston>
Mime-Version: 1.0
Date: 23 Jun 2003 15:05:13 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi !

We all know those need to change, the way they currently work
by returning a linked list of devices is terminally broken
regarding any form of concurrent access...

Here is an example of semantics that I'm implementing in my
tree (no patch below yet, just the definitions), with the additional
notes below:

 - Though I haven't implemented refcounting, I added a get/put()
set of functions and define that all of those "find" functions
will return a got'en object that need to be put. That will allow
us to add proper refcounting implementation later, or wrap a
kobject in there. The get() function is actually more a try_get()
(the idea is that a remove in progress would make it fail)

 - What about renaming struct device_node to struct of_node ? We
could keep a #define for now (2.5) and get rid of device_node
later ? I find the current naming confusing.

Here we go:

extern struct device_node *of_find_device_by_name(struct device_node
*from,
	const char *name);
extern struct device_node *of_find_device_by_type(struct device_node
*from,
	const char *type);
extern struct device_node *of_find_compatible_device(struct device_node
*from,
	const char *type, const char *compat);
extern struct device_node *of_find_device_by_path(const char *path);
extern struct device_node *of_find_all_devices(struct device_node
*prev);
extern int of_device_get(struct device_node *node);
extern int of_device_put(struct device_node *node);

Comments ?

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
